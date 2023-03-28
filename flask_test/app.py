from flask import Flask, request, jsonify, render_template, redirect, url_for
from flask_httpauth import HTTPBasicAuth
from sqlalchemy import create_engine, Column, Integer, String, JSON, Table, select, MetaData, text, Text
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from werkzeug.security import generate_password_hash, check_password_hash
import yaml
import json
from random_rests import get_random_rests, menu

# create Flask app
app = Flask(__name__)

# create HTTP basic authentication
auth = HTTPBasicAuth()

# create SQLAlchemy engine
with open("../config.yml", 'r') as stream:
    try:
        configs = yaml.safe_load(stream)
    except yaml.YAMLError as exc:
        raise exc('Error while parsing the config file')

host = configs['mysql_host']
port = configs['mysql_port']
username = configs['username']
password = configs['password']
database = configs['database']

engine = create_engine(f'mysql+pymysql://{username}:{password}@{host}:{port}/{database}', echo=True)

# with engine.connect() as con:
#     metadata = MetaData()
#     table = Table(
#         'menu',
#         metadata,
#         Column("id", Integer, primary_key=True),
#         Column("menu_name", String(50)),
#         Column("menu_image", String(256)),
#         Column("restaurant", String(256)),
#         Column("price", Integer),
#     )
#     con.execute(table.insert(), menu)
#     con.commit()
#     exit(0)

# create SQLAlchemy session
Session = sessionmaker(bind=engine, autoflush=True)
session = Session()

# create SQLAlchemy base
Base = declarative_base()
metadata = MetaData()

# create User model
class User(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True)
    email = Column(String(50), unique=True, nullable=False)
    password_hash = Column(String(128), nullable=False)
    contact = Column(String(10), nullable=True)
    address = Column(String(200), nullable=True)

    def __repr__(self):
        return f'<User {self.email}>'

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)


class Restaurant(Base):
    __tablename__ = 'restaurant'
    id = Column(Integer, primary_key=True)
    name = Column(String(50), nullable=False)
    image_url = Column(String(256), nullable=False)
    rating = Column(Integer, nullable=True)


class Menu(Base):
    __tablename__ = 'menu'
    id = Column(Integer, primary_key=True)
    menu_name = Column(String(50), nullable=True)
    menu_image = Column(String(256), nullable=True)
    restaurant = Column(String(200), nullable=True)
    price = Column(String(200), nullable=True)


class Order(Base):
    __tablename__ = 'orders'
    id = Column(Integer, primary_key=True)
    name = Column(String(50), nullable=True)
    image_url = Column(String(256), nullable=True)
    price = Column(Integer, nullable=True)
    quantity = Column(Integer, nullable=True)


class Payment(Base):
    __tablename__ = 'payment'
    id = Column(Integer, primary_key=True)
    amount = Column(Integer, nullable=True)
    order = Column(String(200), nullable=True)


# create users table
Base.metadata.create_all(engine)


# verify email and password
@auth.verify_password
def verify_password(email, password):
    user = session.query(User).filter_by(email=email).first()
    if user and user.check_password(password):
        return user

@app.route('/login', methods=['GET', 'POST'])
def login():
    try:
        if request.method == 'POST':
            email = request.form['email']
            password = request.form['password']
            user = session.query(User).filter_by(email=email).first()
            if user and user.check_password(password):
                session.add(user)
                session.commit()
                return jsonify({'status': 200, 'message': 'success'})
            else:
                error_msg = 'Invalid email or password'
                return jsonify({'status': 401, 'message': error_msg})
    except:
        session.rollback()

    
@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        contact = request.form.get('contact', None)
        address = request.form.get('address', None)
        password_hash = generate_password_hash(password)

        if not email or not password:
            return jsonify({'success': False, 'message': 'email and password are required.', 'status': 400})

        try:
            user = session.query(User).filter_by(email=email).first()
            if not email or not password:
                return jsonify({'success': False, 'message': 'email and password are required.', 'status': 400})
            if user:
                return jsonify({'success': False, 'message': 'email already exists.', 'status': 409})
        except:
            session.rollback()
            return jsonify({'success': False, 'message': 'Error while registering a new account', 'status': 409})
            

        user = User(email=email, password_hash=password_hash, contact=contact, address=address)
        session.add(user)
        session.commit()
        return jsonify({'success': True, 'message': 'Successfully created a new account', 'status': 200})


@app.route('/rests', methods=['GET', 'POST'])
def restaurants():
    try:
        if request.method == 'GET':
            all_rest = []
            rests = session.execute(text('select * from restaurant'))
            for rest in rests:
                restaurant = {
                    'id': rest[0],
                    'name': rest[1],
                    'image': rest[2],
                    'rating': rest[3]
                }
                all_rest.append(restaurant)
            return all_rest
        elif request.method == 'POST':
            args = request.form
            rests  = Restaurant(name=args['name'], image_url=args['image_url'], rating=args['rating'])
            session.add(rests)
            session.commit()
            return jsonify({'success': True, 'message': f'Successfully created a restaurant: {args["name"]}'})
    except:
        session.rollback()


@app.route('/menu', methods=['GET', 'POST'])
def menus():
    try:
        # restaurant = args['restaurant']
        if request.method == 'GET':
            all_menu = []
            args = request.args
            restaurant = args.get('restaurant', 'Pizza Hut')
            # menus = session.execute(text(f'select * from menu where restaurant = "{restaurant}"'))
            # for m in menus:
            #     restaurant = {
            #         'id': m[0],
            #         'menu_name': m[1],
            #         'menu_image': m[2],
            #         'restaurant': m[3],
            #         'price': int(m[4])
            #     }
            #     all_menu.append(restaurant)
            # return all_menu
            return {restaurant: menu}

        elif request.method == 'POST':
            args = request.form
            rests  = Menu(menu_name=args['menu_name'], menu_image=args['menu_image'], price=args['price'], restaurant=args['restaurant'])
            session.add(rests)
            session.commit()
            return jsonify({'success': True, 'message': f'Successfully created a menu for restaurant: {args["restaurant"]}'})
    except:
        session.rollback()


@app.route('/order', methods=['GET', 'POST', 'DELETE'])
def orders():
    try:
        if request.method == 'GET':
            all_orders = []
            args = request.form
            orders = session.execute(text(f'select * from orders'))
            for order in orders:
                _order = {
                    'id': order[0],
                    'name': order[1],
                    'image_url': order[2],
                    'price': order[3],
                    'quantity': order[4]
                }
                all_orders.append(_order)
            return jsonify(all_orders)

        elif request.method == 'POST':
            args = request.form
            orders  = Order(name=args['name'], image_url=args['image_url'], price=args['price'], quantity=args['quantity'])
            session.add(orders)
            session.commit()
            return jsonify({'success': True, 'message': f'Successfully created an order'})
        elif request.method == 'DELETE':
            session.execute(text(f'truncate orders'))
            return jsonify({'success': True, 'message': f'Successfully removed content of order table'})
    except:
        session.rollback()


@app.route('/payment', methods=['GET', 'POST'])
def payment():
    try:
        if request.method == 'GET':
            table = Table('payment', metadata)
            select_stmt = select([table])
            result = session.execute(select_stmt)
            return jsonify({'success': True, 'data': result})
        elif request.method == 'POST':
            args = request.form
            amount = args['amount']
            order = args['order']
            rests  = Payment(amount=amount, order=order)
            session.add(rests)
            session.commit()
            return jsonify({'success': True, 'message': f'Successfully created a payment for order: {order}'})
    except:
        session.rollback()


# -----------------------------------------------------------------------
# @app.route("/rests",methods=["GET", "POST"])
# def get_restros():
#     all_res = []
#     for i in range(1, 21):
#         doc = {
#             'name': f'rest-{i}',
#             'image': 'https://images.hindustantimes.com/rf/image_size_960x540/HT/p2/2018/12/15/Pictures/_9f2b6346-ffd3-11e8-9457-b1b429387a4e.jpg',
#         }
#         all_res.append(doc)
#     return all_res


# @app.route("/menu",methods=["GET", "POST"])
# def get_menu():
#     all_menu = []
#     args = request.args
#     restaurant = args.get('restaurant', 'blueberry')
#     if restaurant == "":
#         restaurant = 'blueberry'
#     for i in range(1, 21):
#         doc = {
#             'menu_name': f'{restaurant}-menu-{i}',
#             'menu_image': 'https://b.zmtcdn.com/data/pictures/chains/5/3000095/b5200d2866c85d4d734f59a6f60b2ae1.jpg',
#             'price': 450,
#         }
#         all_menu.append(doc)
#     return {restaurant: all_menu}


if __name__ == '__main__':
    app.run(debug=True, port=5000)

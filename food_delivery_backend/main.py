from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
import os
import yaml

app = Flask(__name__)
basedir = os.path.abspath(os.path.dirname(__file__))

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

app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql+pymysql://{username}:{password}@{host}:{port}/{database}'

app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
ma = Marshmallow(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(100))
    email = db.Column(db.String(100), unique=True)
    password = db.Column(db.String(100))
    contact = db.Column(db.String(10))
    address = db.Column(db.String(100))

    def __init__(self, username, email, password, contact, address):
        self.username = username
        self.email = email
        self.password = password
        self.contact = contact
        self.address = address

class Restaurant(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    restaurant_name = db.Column(db.String(100))
    contact = db.Column(db.String(100))
    address = db.Column(db.String(100))

    def __init__(self, restaurant_name, contact, address):
        self.restaurant_name = restaurant_name
        self.contact = contact
        self.address = address

class Menu(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    menu_name = db.Column(db.String(100))
    menu_category = db.Column(db.String(100))
    price = db.Column(db.String(100))
    image = db.Column(db.String(1000))

    def __init__(self, menu_name, menu_category, price, image):
        self.menu_name = menu_name
        self.menu_category = menu_category
        self.price = price
        self.image = image

class Order(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    customer_name = db.Column(db.String(100))
    quantity = db.Column(db.String(100))
    date = db.Column(db.String(100))

    def __init__(self, customer_name, quanity, date):
        self.customer_name = customer_name
        self.quantity = quanity
        self.date = date

class Payment(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    order_id = db.Column(db.String(100))
    order_date = db.Column(db.String(100))

    def __init__(self, order_id, order_date):
        self.order_id = order_id
        self.order_date = order_date

# User schema
class UserSchema(ma.Schema):
    class Meta:
        fields = ('id', 'username', 'email', 'password', 'contact', 'address')

# Restaurant schema
class RestaurantSchema(ma.Schema):
    class Meta:
        fields = ('id', 'restaurant_name', 'contact', 'address')

# Menu schema
class MenuSchema(ma.Schema):
    class Meta:
        fields = ('id', 'menu_name', 'menu_category', 'price', 'image')

# Order schema
class OrderSchema(ma.Schema):
    class Meta:
        fields = ('id', 'customer_name', 'quantity', 'date')

# Payment schema
class PaymentSchema(ma.Schema):
    class Meta:
        fields = ('id', 'order_id', 'order_date')

# Initialize schema
user_schema = UserSchema()
users_schema = UserSchema(many=True)

restaurant_schema = RestaurantSchema()
restaurants_schema = RestaurantSchema(many=True)

menu_schema = MenuSchema()
menus_schema = MenuSchema(many=True)

order_schema = OrderSchema()
orders_schema = OrderSchema(many=True)

payment_schema = PaymentSchema()
payments_schema = PaymentSchema(many=True)

@app.route('/login', methods=['POST'])
def add_user():
    # from models.model import User, user_schema
    username = request.json['username']
    email = request.json['email']
    password = request.json['password']
    contact = request.json['contact']
    address = request.json['address']

    user_item = User(username, email, password, contact, address)
    db.session.add(user_item)
    db.session.commit()

    return user_schema.jsonify(user_item)

@app.route('/register', methods=['POST'])
def get_users():
    # from models.model import User, users_schema
    all_users = User.query.all()
    result = users_schema.dump(all_users)

    return jsonify(result)

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)
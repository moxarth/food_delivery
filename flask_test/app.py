from flask import Flask, request, jsonify, render_template, redirect, url_for
from flask_httpauth import HTTPBasicAuth
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from werkzeug.security import generate_password_hash, check_password_hash
import yaml

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

# create SQLAlchemy session
Session = sessionmaker(bind=engine)
session = Session()

# create SQLAlchemy base
Base = declarative_base()

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

# create users table
Base.metadata.create_all(engine)

# create sample user
# user = User(email='admin')
# user.set_password('password')
# session.add(user)
# session.commit()

# verify email and password
@auth.verify_password
def verify_password(email, password):
    user = session.query(User).filter_by(email=email).first()
    if user and user.check_password(password):
        return user

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        user = session.query(User).filter_by(email=email).first()
        if user and user.check_password(password):
            session.add(user)
            session.commit()
            return jsonify({'status': 200, 'message': 'success'})
            # return redirect(url_for('home'))
        else:
            error_msg = 'Invalid email or password'
            return jsonify({'status': 401, 'message': error_msg})
            # return render_template('login.html', error_msg=error_msg)
    # else:
    #     return render_template('login.html')

# @app.route('/')
# @auth.login_required
# def home():
#     return 'Hello, World!'
    
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

if __name__ == '__main__':
    app.run(debug=True, port=5000)

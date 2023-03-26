from flask import Flask,request,jsonify
from flask_sqlalchemy import SQLAlchemy
import yaml
from random_rests import menu, get_random_rests

# with open("../config.yml", 'r') as stream:
#     try:
#         configs = yaml.safe_load(stream)
#     except yaml.YAMLError as exc:
#         raise exc('Error while parsing the config file')

# host = configs['mysql_host']
# port = configs['mysql_port']
# username = configs['username']
# password = configs['password']
# database = configs['database']

app = Flask(__name__)

@app.route("/rests",methods=["GET", "POST"])
def get_restros():
    all_res = get_random_rests()
    return all_res


@app.route("/menu",methods=["GET", "POST"])
def get_menu():
    all_menu = []
    args = request.args
    restaurant = args.get('restaurant', 'blueberry')
    if restaurant == "":
        restaurant = 'blueberry'
    for i in range(1, 21):
        doc = {
            'menu_name': f'{restaurant}-menu-{i}',
            'menu_image': 'https://b.zmtcdn.com/data/pictures/chains/5/3000095/b5200d2866c85d4d734f59a6f60b2ae1.jpg',
            'price': 450,
        }
        all_menu.append(doc)
    return {restaurant: all_menu}

# app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql+pymysql://{username}:{password}@{host}:{port}/{database}'
# db = SQLAlchemy(app)

# # this class is for creating tables in db
# class user(db.Model):
#     id = db.Column(db.Integer, primary_key=True)
#     username = db.Column(db.String(80))
#     email = db.Column(db.String(120))
#     password = db.Column(db.String(80))
#     contact = db.Column(db.String(10))
#     address = db.Column(db.String(200))

# @app.route("/login",methods=["GET", "POST"])
# def login():
#     d = {}
#     if request.method == "POST":
#         uname = request.form["uname"]
#         passw = request.form["passw"]
        
#         login = user.query.filter_by(username=uname, password=passw).first()

#         if login is not None:
#             # account found
#             d["status"] = 11
#             return jsonify(d)
#         else:
#             # account not exist
#             d["status"] = 22
#             return jsonify(d)
            


# @app.route("/register", methods=["GET", "POST"])
# def register():
#     d = {}
#     if request.method == "POST":
#         uname = request.form['uname']
#         mail = request.form['mail']
#         passw = request.form['passw']
#         username = user.query.filter_by(username=uname).first()
#         if username is None:
#             register = user(username = uname, email = mail, password = passw)
#             db.session.add(register)
#             db.session.commit()
#             d["status"] = 11
#             return jsonify(d)
#         else:
#             # already exist
#             d["status"] = 22
#             return jsonify(d)

if __name__ == "__main__":
    # db.create_all()
    app.run(debug=True, port=5001)
# run with `APP_NAME=<some identifier> FLASK_APP=app.py flask run`
import os
from flask import Flask

app = Flask(__name__)
APP_NAME = os.getenv('APP_NAME')
assert APP_NAME, "APP_NAME not set"

@app.route("/")
def hello():
    return "Hello from app %s!" % APP_NAME

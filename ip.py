import socket
from flask import Flask
from flask import render_template
from os import environ

app = Flask(__name__)

@app.route('/')
def index():
    app.config['COLOR'] = environ.get('COLOR')
    hostname = socket.gethostbyname(socket.gethostname())
    return render_template('index.html', message=hostname, color=app.config['COLOR'])
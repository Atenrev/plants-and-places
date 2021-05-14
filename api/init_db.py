from flaskr import db
from flaskr import create_app
db.create_all(app=create_app())
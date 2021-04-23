import os
import functools
from werkzeug.utils import secure_filename
from flask import (
    Blueprint, flash, g, redirect, render_template, request, session, url_for, current_app
)
from .models import plant_location

bp = Blueprint('api', __name__, url_prefix='/api')
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', }


def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@bp.route('/plants/', methods=('GET', ))
def plant_locations_list():
    plant_locations = plant_location.all()

    return {
        "data": [{
            "name": plant['name'],
            "latitude": plant['latitude'],
            "longitude": plant['longitude'],
            "image_path": plant['image_path'],
        } for plant in plant_locations],
        "status": "ok",
    }


@bp.route('/plants/create/', methods=('POST', ))
def plant_locations_create():
    print(request.data)

    if (
        request.form is None
        or 'name' not in request.form
        or 'latitude' not in request.form
        or 'longitude' not in request.form
    ):
        return "Bad Request", 400

    image_path = None

    if 'image' in request.files:
        file = request.files['image']
        # if user does not select file, browser also
        # submit an empty part without filename
        if file.filename == '':
            return "Bad Request", 400
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(current_app.config['MEDIA_PATH'], filename))
            image_path = current_app.config['MEDIA_URL'] + filename
        else:
            return "Bad Request", 400
        

    plant_location.create(
        request.form['name'],
        request.form['latitude'],
        request.form['longitude'],
        image_path
    )

    return 'Created', 201

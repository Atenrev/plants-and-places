import os
from flask import Flask, send_from_directory


def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        SECRET_KEY='dev',
        DATABASE=os.path.join(app.instance_path, 'flaskr.sqlite'),
        MEDIA_PATH=os.path.join(app.instance_path, 'uploads'),
        MEDIA_URL='/uploads/',
    )

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

    # ensure the instance folder exists
    try:
        print(app.config['MEDIA_PATH'])
        os.makedirs(app.instance_path)
        os.makedirs(app.config['MEDIA_PATH'])
    except OSError:
        pass

    # Import blueprints
    from . import api
    app.register_blueprint(api.bp)

    from . import db
    db.init_app(app)

    @app.route('/uploads/<filename>')
    def media(filename):
        return send_from_directory(app.config['MEDIA_PATH'], filename)

    return app
from flaskr.db import get_db


def all():
    db = get_db()
    plant_locations = db.execute(
        """SELECT * FROM plant_location"""
    ).fetchall()
    return plant_locations


def create(name, latitude, longitude, image_path=None):
    db = get_db()
    db.execute(
        'INSERT INTO plant_location (name, latitude, longitude, image_path) VALUES (?, ?, ?, ?)',
        (name, latitude, longitude, image_path)
    )
    db.commit()

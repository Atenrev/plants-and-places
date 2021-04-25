DROP TABLE IF EXISTS plant_location;

CREATE TABLE plant_location (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR NOT NULL,
  latitude FLOAT NOT NULL,
  longitude FLOAT NOT NULL,
  image_path VARCHAR
);
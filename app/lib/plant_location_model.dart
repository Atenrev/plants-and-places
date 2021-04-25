import 'dart:io';

import 'package:plants_and_places/constants.dart';

class PlantLocationModel {
  final int id;
  final String name;
  final String image;
  final File imageFile;
  final double latitude;
  final double longitude;

  PlantLocationModel(
      {this.id,
      this.name,
      this.image,
      this.imageFile,
      this.latitude,
      this.longitude});

  factory PlantLocationModel.fromJson(Map<String, dynamic> json) {
    return PlantLocationModel(
        id: json['id'],
        name: json['name'],
        image: json['image_path'] != null ? SERVER_DOMAIN + json['image_path'] : null,
        latitude: json['latitude'],
        longitude: json['longitude']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      };

  @override
  bool operator ==(Object other) =>
      other is PlantLocationModel && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

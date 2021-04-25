import 'dart:async';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:plants_and_places/plant_location_model.dart';

import './constants.dart';
import 'widgets/dialogs.dart';

const baseUrl = "$SERVER_DOMAIN/api/v1";
const commonHeaders = {
  'App-Auth': 'SistemesMultimedia2021',
};

class APIResponse {
  String message;
  int responseCode;
  String errorCode;
  bool success;
  Object object;
  APIResponse(
      {this.message,
      this.success,
      this.errorCode,
      this.responseCode,
      this.object});
}

class RESTAPI {
  static Future<APIResponse> listPlantLocations() async {
    var url = "$baseUrl/plants/";
    http.Response response;

    try {
      response = await http.get(
        url,
        headers: <String, String>{}..addAll(commonHeaders),
      );
    } catch (e) {
      return new APIResponse(
        success: false,
        errorCode: 'connection_error',
      );
    }

    if (response.statusCode == 404) {
      return new APIResponse(
        success: true,
        object: const <PlantLocationModel>[],
      );
    }

    Iterable list = json.decode(utf8.decode(response.bodyBytes))['data'];
    List<PlantLocationModel> plantLocations =
        list.map((model) => PlantLocationModel.fromJson(model)).toList();

    return new APIResponse(
      success: true,
      object: plantLocations,
    );
  }

  static Future<APIResponse> createPlantLocation(
      PlantLocationModel plantLocation) async {
    var url = "$baseUrl/plants/create/";
    var uri = Uri.parse(url);
    var response;

    var stream = new http.ByteStream(plantLocation.imageFile.openRead());
    var length = await plantLocation.imageFile.length();
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(plantLocation.imageFile.path));
    request.files.add(multipartFile);

    commonHeaders.forEach((k, v) {
      request.headers[k] = v;
    });
    plantLocation.toJson().forEach((k, v) {
      request.fields[k] = v;
    });

    try {
      response = await request.send();
      // response = await http.post(
      //   url,
      //   headers: <String, String>{}..addAll(commonHeaders),
      //   body: plantLocation.toJson(),
      // );
    } catch (e) {
      return new APIResponse(
        success: false,
        errorCode: 'connection_error',
      );
    }

    return new APIResponse(
      success: true,
      responseCode: response.statusCode,
    );
  }
}

Future<Position> getCurrentLocation(context) async {
  Position currentLocation;
  bool success = false;
  int intents = 0;

  while (!success || currentLocation == null) {
    try {
      currentLocation = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .timeout(Duration(seconds: 3), onTimeout: () {
        final Geolocator geolocatorObj = new Geolocator();
        geolocatorObj.forceAndroidLocationManager = true;
        return geolocatorObj
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
            .timeout(Duration(seconds: 3));
      });
      success = true;
    } catch (err) {
      intents++;

      if (intents >= 10) {
        await showErrorDialog(
          context,
          title: "Es necessiten els serveis d'ubicació",
          message:
              "Aquesta aplicació fa ús de la seva ubicació per mostrar-li les plantes del seu entorn i, en cas que vosté en faci alguna aportació, lligar la seva ubicació actual amb la imatge pujada.",
        );
        intents = 0;
      }
    }
  }

  return currentLocation;
}

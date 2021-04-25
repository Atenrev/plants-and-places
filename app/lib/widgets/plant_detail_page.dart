import 'package:flutter/material.dart';
import 'package:plants_and_places/plant_location_model.dart';

class PlantDetailPage extends StatelessWidget {
  static const String id = "detail";
  final PlantLocationModel plantLocationModel;

  const PlantDetailPage(this.plantLocationModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.clear),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          plantLocationModel.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              plantLocationModel.image,
              height: MediaQuery.of(context).size.height * 0.95,
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}

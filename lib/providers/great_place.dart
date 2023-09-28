import 'package:flutter/material.dart';
import '../models/place.dart';
import 'dart:io';
import '../helper/db_helper.dart';
import '../helper/map_helper.dart';

class GreatPlace with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  Place getPlaceById(String id) {
    return _places.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(String title, File image, PlaceLocation locData) async {
    final address =
        await MapHelper.getAddressDetails(locData.latitude, locData.longitude);
    // print("address $address");
    final PlaceLocation updatedLocation = PlaceLocation(
        latitude: locData.latitude,
        longitude: locData.longitude,
        address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        image: image,
        location: updatedLocation);
    _places.add(newPlace);
    notifyListeners();
    DbHelper.insert('User_Places', {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "loc_lat": updatedLocation.latitude,
      "loc_lng": updatedLocation.longitude,
      "address": updatedLocation.address!
    });
  }

  Future<void> fetchAndSetPlace() async {
    final data = await DbHelper.getData('User_Places');

    _places = data
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
                latitude: item['loc_lat'],
                longitude: item['loc_lng'],
                address: item['address'])))
        .toList();
    notifyListeners();
  }
}

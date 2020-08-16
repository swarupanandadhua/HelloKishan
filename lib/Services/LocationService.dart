import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Stream<Position> get location {
    Geolocator()
      ..forceAndroidLocationManager
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then(
        (pos) {
          return pos;
        },
      );
    return null;
  }

  Future<Position> fetchLocation() async {
    Geolocator()
      ..forceAndroidLocationManager
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then(
        (pos) {
          debugPrint('Latitude: ' + pos.latitude.toString());
          debugPrint('Longitude: ' + pos.longitude.toString());
          return pos;
        },
      );
    return null;
  }
}

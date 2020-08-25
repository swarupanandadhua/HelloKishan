import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
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

  void printAddress() async {
    Geolocator()
      ..forceAndroidLocationManager
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then((pos) async {
        final coordinates = Coordinates(pos.latitude, pos.longitude);
        List<Address> addresses =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
        Address first = addresses.first;
        debugPrint('-------------------------------------');
        debugPrint(first.addressLine);
        debugPrint(first.adminArea);
        debugPrint(first.coordinates.toString());
        debugPrint(first.countryCode);
        debugPrint(first.countryName);
        debugPrint(first.featureName);
        debugPrint(first.locality);
        debugPrint(first.postalCode);
        debugPrint(first.subAdminArea);
        debugPrint(first.subLocality);
        debugPrint(first.subThoroughfare);
        debugPrint(first.thoroughfare);
        debugPrint('-------------------------------------');
      });
  }
}

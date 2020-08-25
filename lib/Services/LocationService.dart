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
        print('-------------------------------------');
        print(first.addressLine);
        print(first.adminArea);
        print(first.coordinates);
        print(first.countryCode);
        print(first.countryName);
        print(first.featureName);
        print(first.locality);
        print(first.postalCode);
        print(first.subAdminArea);
        print(first.subLocality);
        print(first.subThoroughfare);
        print(first.thoroughfare);
        print('-------------------------------------');
      });
  }
}

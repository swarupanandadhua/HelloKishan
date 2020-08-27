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

  Future<Address> getAddress() async {
    Geolocator g = Geolocator();
    g.forceAndroidLocationManager = true;
    Position pos =
        await g.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    final latlong = Coordinates(pos.latitude, pos.longitude);
    List<Address> addresses =
        await Geocoder.local.findAddressesFromCoordinates(latlong);
    Address address = addresses.first;
    debugPrint('-------------------------------------');
    debugPrint('addressLine: ' + address.addressLine.toString());
    debugPrint('adminArea: ' + address.adminArea.toString());
    debugPrint('coordinates: ' + address.coordinates.toString());
    debugPrint('countryCode: ' + address.countryCode.toString());
    debugPrint('countryName: ' + address.countryName.toString());
    debugPrint('featureName: ' + address.featureName.toString());
    debugPrint('locality: ' + address.locality.toString());
    debugPrint('postalCode: ' + address.postalCode.toString());
    debugPrint('subAdminArea: ' + address.subAdminArea.toString());
    debugPrint('subLocality: ' + address.subLocality.toString());
    debugPrint('subThoroughfare: ' + address.subThoroughfare.toString());
    debugPrint('thoroughfare: ' + address.thoroughfare.toString());
    debugPrint('-------------------------------------');
    return address;
  }
}

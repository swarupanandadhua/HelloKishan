import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> fetchLocation() async {
    return await GeolocatorPlatform.instance.getCurrentPosition(
      forceAndroidLocationManager: true,
      desiredAccuracy: LocationAccuracy.best,
    );
  }

  Future<Address> getAddress() async {
    Position pos = await fetchLocation();
    List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(
      Coordinates(pos.latitude, pos.longitude),
    );
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

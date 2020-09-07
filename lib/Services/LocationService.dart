import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class LocationService {
  static Future<LocationData> fetchLocation() async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    serviceEnabled = serviceEnabled ?? await location.requestService();
    if (!serviceEnabled) {
      return null;
    }

    PermissionStatus permission = await location.hasPermission();

    permission = (permission == PermissionStatus.granted)
        ? permission
        : await location.requestPermission();

    if (permission != PermissionStatus.granted) {
      return null;
    }
    debugPrint('TODO: BUG: Getting stuck if location off');
    LocationData l = await location.getLocation().catchError((e) {
      debugPrint(e);
    });
    debugPrint('---------Stuck passed-----------');
    return l;
  }

  static Future<Address> getAddress() async {
    LocationData pos = await fetchLocation();
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

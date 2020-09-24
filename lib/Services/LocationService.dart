import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Address> getAddress() async {
    Position p = await getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    if (p == null) return null;
    List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(
      Coordinates(p.latitude, p.longitude),
    );
    return addresses?.first;
  }
}

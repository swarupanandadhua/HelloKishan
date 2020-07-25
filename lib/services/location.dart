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
          print("Latitude: " + pos.latitude.toString());
          print("Longitude: " + pos.longitude.toString());
          return pos;
        },
      );
    return null;
  }
}

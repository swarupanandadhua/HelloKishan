import 'package:geolocator/geolocator.dart';

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

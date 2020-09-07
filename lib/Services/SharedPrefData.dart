import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefData {
  static SharedPreferences p;

  static Future<void> init() async =>
      p = p ?? await SharedPreferences.getInstance();

  static void setProfileUpdated() => p.setBool('profileUpdated', true);
  static bool getProfileUpdated() => p.getBool('profileUpdated');

  static void setAddress(String addressLine) =>
      p.setString('address', addressLine);
  static String getAddress() => p.getString('address');

  static void setDistrict(String district) => p.setString('district', district);
  static String getDistrict() => p.getString('district');

  static void setState(String state) => p.setString('state', state);
  static String getState() => p.getString('state');

  static void setPincode(String pincode) => p.setString('pincode', pincode);
  static String getPincode() => p.getString('pincode');

  static void setLatitude(double latitude) => p.setDouble('latitude', latitude);
  static double getLatitude() => p.getDouble('latitude');

  static void setLongitude(double longitude) =>
      p.setDouble('longitude', longitude);
  static double getLongitude() => p.getDouble('longitude');

  static void setFCMToken(String token) => p.setString('fcmToken', token);
  static String getFCMToken() => p.getString('fcmToken');

  static void reset(String key) => p.remove(key);
}

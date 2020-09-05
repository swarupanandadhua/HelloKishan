import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefData {
  static SharedPreferences p;

  static Future<void> init() async =>
      p = p ?? await SharedPreferences.getInstance();

  static void setProfileUpdated() => p.setBool('profileUpdated', true);
  static bool getProfileUpdated() => p.getBool('profileUpdated');

  static void setUid(String uid) => p.setString('uid', uid);
  static String getUid() => p.getString('uid');

  static void setName(String name) => p.setString('name', name);
  static String getName() => p.getString('name');

  static void setMobile(String mobile) => p.setString('mobile', mobile);
  static String getMobile() => p.getString('mobile');

  static void setPhotoURL(String url) => p.setString('photoURL', url);
  static String getPhotoURL() => p.getString('photoURL');

  static void setAddressLine(String addressLine) =>
      p.setString('addressLine', addressLine);
  static String getAddressLine() => p.getString('addressLine');

  static void setDistrict(String district) => p.setString('district', district);
  static String getDistrict() => p.getString('district');

  static void setState(String state) => p.setString('state', state);
  static String getState() => p.getString('state');

  static void setPincode(String pincode) => p.setString('pincode', pincode);
  static String getPincode() => p.getString('pincode');

  static void setFCMToken(String token) => p.setString('fcmToken', token);
  static String getFCMToken() => p.getString('fcmToken');

  static void reset(String key) => p.remove(key);
}

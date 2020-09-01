import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefData {
  static SharedPreferences pref;
  static String uid, fcmToken;
  static bool profileUpdated;

  static Future<void> initialize() async {
    if (pref == null) {
      pref = await SharedPreferences.getInstance();
    }
  }

  static String getUid() {
    return pref.getString('uid');
  }

  static String getFCMToken() {
    return pref.getString('fcmToken');
  }

  static bool getProfileUpdated() {
    return pref.getBool('profileUpdated');
  }

  static void setProfileUpdated() {
    pref.setBool('profileUpdated', true);
  }

  static void setString(String key, String value) {
    pref.setString(key, value);
  }

  static void setBool(String key, bool value) {
    pref.setBool(key, value);
  }

  static void reset(String key) {
    pref.remove(key);
  }
}

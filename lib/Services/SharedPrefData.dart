import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefData {
  static SharedPreferences pref;
  static String uid, fcmToken;
  static bool profileUpdated;

  static Future<SharedPreferences> getPref() async {
    if (pref == null) {
      pref = await SharedPreferences.getInstance();
    }
    return pref;
  }

  static Future<String> getUid() async {
    if (uid == null) {
      uid = await getPref().then(
        (pref) => pref.getString('uid'),
      );
    }
    return uid;
  }

  static Future<String> getFCMToken() async {
    if (fcmToken == null) {
      fcmToken = await getPref().then(
        (pref) => pref.getString('fcmToken'),
      );
    }
    return fcmToken;
  }

  static Future<bool> getProfileUpdated() async {
    if (profileUpdated == null) {
      profileUpdated = await getPref().then(
        (pref) => pref.getBool('profileUpdated'),
      );
    }
    return profileUpdated;
  }

  static void setString(String key, String value) async {
    getPref().then(
      (pref) => pref.setString(key, value),
    );
  }

  static void setBool(String key, bool value) async {
    getPref().then(
      (pref) => pref.setBool(key, value),
    );
  }

  static void reset(String key) async {
    getPref().then(
      (pref) => pref.remove(key),
    );
  }
}

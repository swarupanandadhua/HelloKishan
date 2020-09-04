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

  static String getUid() => pref.getString('uid');

  static String getFCMToken() => pref.getString('fcmToken');

  static bool getProfileUpdated() => pref.getBool('profileUpdated');

  static void setProfileUpdated() => pref.setBool('profileUpdated', true);

  static void setString(String key, String value) {
    pref.setString(key, value);
  }

  static void setBool(String key, bool value) {
    pref.setBool(key, value);
  }

  static void reset(String key) => pref.remove(key);

  static void setName(String name) => pref.setString('name', name);

  static String getName() => pref.getString('name');

  static void setPhotoURL(String url) => pref.setString('photoURL', url);

  static String getPhotoURL() => pref.getString('photoURL');
}

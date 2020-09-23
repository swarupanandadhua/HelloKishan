import 'package:FarmApp/Models/Colors.dart';
import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Models/Styles.dart';
import 'package:FarmApp/Screens/Common/LoadingScreen.dart';
import 'package:FarmApp/Screens/Profile/OTPLoginScreen.dart';
import 'package:FarmApp/Screens/Profile/ProfileUpdateScreen.dart';
import 'package:FarmApp/Services/AuthService.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Drawer(
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfileUpdateScreen(false, false),
                  ),
                );
              },
              child: Container(
                child: DrawerHeader(
                  child: Column(
                    children: [
                      Text(
                        FirebaseAuth.instance.currentUser.displayName,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        height: 100,
                        width: 100,
                        child: ClipOval(
                          child: Image.network(
                            FirebaseAuth.instance.currentUser.photoURL,
                            loadingBuilder: (_, c, p) {
                              if (p == null) return c;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: p.expectedTotalBytes != null
                                      ? p.cumulativeBytesLoaded /
                                          p.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (_, __, ___) => ImageAsset.account,
                          ),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(color: Color(APP_COLOR)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(STRING_LANGUAGE, style: styleNavItem),
                leading: Icon(Icons.language),
                onTap: () {
                  if (EasyLocalization.of(context).locale.toString() ==
                      'bn_IN') {
                    EasyLocalization.of(context).locale = Locale('en', 'US');
                  } else {
                    EasyLocalization.of(context).locale = Locale('bn', 'IN');
                  }
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(STRING_SHARE, style: styleNavItem),
                leading: Icon(Icons.share),
                onTap: () => UrlLauncher.launch(STRING_SHARE_ARG),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(STRING_HELP, style: styleNavItem),
                leading: Icon(Icons.help_outline),
                onTap: () => UrlLauncher.launch(HELP_MAIL_ARG),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(STRING_SIGN_OUT, style: styleNavItem),
                leading: Icon(Icons.power_settings_new),
                onTap: () async {
                  await AuthService.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OTPLoginScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

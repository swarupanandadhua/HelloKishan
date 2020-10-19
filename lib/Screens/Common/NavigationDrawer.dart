import 'package:HelloKishan/Models/Colors.dart';
import 'package:HelloKishan/Models/Constants.dart';
import 'package:HelloKishan/Models/Strings.dart';
import 'package:HelloKishan/Models/Styles.dart';
import 'package:HelloKishan/Screens/Common/GlobalKeys.dart';
import 'package:HelloKishan/Screens/Common/HelloKishanDialog.dart';
import 'package:HelloKishan/Screens/Common/ProfilePicture.dart';
import 'package:HelloKishan/Screens/Profile/OTPLoginScreen.dart';
import 'package:HelloKishan/Screens/Profile/ProfileUpdateScreen.dart';
import 'package:HelloKishan/Services/AuthService.dart';
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
                    builder: (_) => ProfileUpdateScaffold(false, false),
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
                          child: ProfilePicture.getProfilePicture(
                            FirebaseAuth.instance.currentUser.photoURL,
                          ),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(color: Color(APP_COLOR)),
                ),
              ),
            ),
            // TODO: Language support
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(STRING_LANGUAGE.tr(), style: styleNavItem),
                leading: Icon(Icons.language),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (_) => HelloKishanDialog.languagePickerDialog(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(STRING_SHARE.tr(), style: styleNavItem),
                leading: Icon(Icons.share),
                onTap: () => UrlLauncher.launch(STRING_SHARE_ARG.tr()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(STRING_HELP.tr(), style: styleNavItem),
                leading: Icon(Icons.help_outline),
                onTap: () => UrlLauncher.launch(HELP_MAIL_ARG),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(STRING_SIGN_OUT.tr(), style: styleNavItem),
                leading: Icon(Icons.power_settings_new),
                onTap: () async {
                  HelloKishanDialog.show(
                    GlobalKeys.wrapperScaffoldKey.currentContext,
                    // TODO: ISSUE: The above context was poped earlier
                    STRING_SIGNING_OUT.tr(),
                    true,
                  );
                  bool status = await AuthService.signOut();
                  HelloKishanDialog.hide();
                  if (status == true) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OTPLoginScreen(),
                      ),
                      (route) => false,
                    );
                  } else {
                    HelloKishanDialog.show(
                      GlobalKeys.wrapperScaffoldKey.currentContext,
                      STRING_SIGNING_OUT_FAILED.tr(),
                      false,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

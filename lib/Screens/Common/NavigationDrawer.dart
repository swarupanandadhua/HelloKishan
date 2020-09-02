import 'package:FarmApp/Models/Colors.dart';
import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Profile/OTPLoginScreen.dart';
import 'package:FarmApp/Services/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User u = Provider.of<User>(context, listen: false);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () => debugPrint(StackTrace.current.toString()),
              // TODO: Show Profile Picture as well
              child: Container(
                height: 120,
                child: DrawerHeader(
                  child: Column(
                    children: [
                      Text(
                        u?.displayName ?? STRING_WELCOME_USER,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(color: Color(APP_COLOR)),
                ),
              ),
            ),
            // TODO: Add leading Icons to the followgs...
            ListTile(
              title: Text(STRING_KYC),
              onTap: () => debugPrint(StackTrace.current.toString()),
            ),
            ListTile(
              title: Text(STRING_HELP),
              onTap: () => UrlLauncher.launch(HELP_MAIL_ARG),
            ),
            ListTile(
              title: Text(STRING_SETTINGS),
              onTap: () => debugPrint(StackTrace.current.toString()),
            ),
            ListTile(
              title: Text(STRING_FEEDBACK),
              onTap: () => debugPrint(StackTrace.current.toString()),
            ),
            ListTile(
              title: Text(STRING_SIGN_OUT),
              onTap: () async {
                await AuthService().signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OTPLoginScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

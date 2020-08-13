import 'package:farmapp/models/constants.dart';
import 'package:farmapp/screens/account/otp_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:farmapp/services/authentication.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseUser u = Provider.of<FirebaseUser>(context, listen: false);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () => debugPrint(StackTrace.current.toString()),
              child: Container(
                height: 120,
                child: DrawerHeader(
                  child: Text(
                    u?.displayName ?? 'Welcome User',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(color: Colors.indigo),
                ),
              ),
            ),
            ListTile(
              title: Text('KYC'),
              onTap: () => debugPrint(StackTrace.current.toString()),
            ),
            ListTile(
              title: Text('Help'),
              onTap: () => UrlLauncher.launch(HELP_MAIL_LAUNCH_ARG),
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () => debugPrint(StackTrace.current.toString()),
            ),
            ListTile(
              title: Text('Feedback'),
              onTap: () => debugPrint(StackTrace.current.toString()),
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: () async {
                await AuthenticationService().signOut();
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

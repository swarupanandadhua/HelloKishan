import 'package:farmapp/models/constants.dart';
import 'package:farmapp/models/models.dart';
import 'package:farmapp/screens/account/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:farmapp/services/authentication.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FarmAppUser u = Provider.of<FarmAppUser>(context, listen: false);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () => print(StackTrace.current),
              child: Container(
                height: 120,
                child: DrawerHeader(
                  child: Text(
                    u.name,
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
              onTap: () => print(StackTrace.current),
            ),
            ListTile(
              title: Text('Help'),
              onTap: () => UrlLauncher.launch(HELP_MAIL_LAUNCH_ARG),
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () => print(StackTrace.current),
            ),
            ListTile(
              title: Text('Feedback'),
              onTap: () => print(StackTrace.current),
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: () async {
                await AuthenticationService().signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthenticateScreen(),
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

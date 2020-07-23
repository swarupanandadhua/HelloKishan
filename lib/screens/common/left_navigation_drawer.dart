import 'package:farmapp/models/constants.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:farmapp/screens/home/wrapper.dart';
import 'package:farmapp/services/authentication.dart';
import 'package:flutter/material.dart';

class LeftNavigationDrawer extends StatelessWidget {
  const LeftNavigationDrawer({Key key}) : super(key: key);

  final String name = "Swarupananda Dhua";

  @override
  Widget build(BuildContext context) {
    final Auth _auth = Auth();

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
                  name,
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                decoration: BoxDecoration(color: Colors.indigo),
              ),
            ),
          ),
          ListTile(
            title: Text("KYC"),
            onTap: () => print(StackTrace.current),
          ),
          ListTile(
            title: Text("Help"),
            onTap: () => UrlLauncher.launch(HELP_MAIL_LAUNCH_ARG),
          ),
          ListTile(
            title: Text("Settings"),
            onTap: () => print(StackTrace.current),
          ),
          ListTile(
            title: Text("Feedback"),
            onTap: () => print(StackTrace.current),
          ),
          ListTile(
            title: Text("Sign Out"),
            onTap: () async {
              await _auth.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Wrapper()),
                (route) => false,
              );
            },
          ),
        ],
      )),
    );
  }
}

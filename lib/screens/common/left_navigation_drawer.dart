import 'package:farmapp/screens/home/wrapper.dart';
import 'package:farmapp/services/auth.dart';
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
            onTap: () => print('TODO: Launch ProfilePage'),
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
            onTap: () {
              // Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            title: Text("Help"),
            onTap: () {
              // Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            title: Text("Settings"),
            onTap: () {
              // Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            title: Text("Feedback"),
            onTap: () {
              // Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
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

import 'package:farmapp/home.dart';
import 'package:farmapp/account.dart';
import 'package:farmapp/services/auth.dart';
import 'package:farmapp/signin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'history.dart';

class BotNavBar extends StatefulWidget {
  final int botNavBarIdx;
  BotNavBar({Key key, this.botNavBarIdx}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BotNavBarState(botNavBarIdx);
  }
}

class BotNavBarState extends State<BotNavBar> {
  int botNavBarIdx;

  BotNavBarState(this.botNavBarIdx);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 16.0,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text('Profile'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.import_export),
          title: Text('Trade'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          title: Text('History'),
        ),
      ],
      currentIndex: botNavBarIdx,
      fixedColor: Colors.indigo,
      onTap: onItemTapped,
    );
  }

  void onItemTapped(int value) {
    setState(() {
      botNavBarIdx = value;
      switch (value) {
        case 0:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
          );
          break;
        case 1:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AccountScreen()),
            (route) => false,
          );
          break;
        case 3:
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HistoryScreen()),
            (route) => false,
          );
          break;
        default:
          assert(false);
      }
    });
  }
}

class LeftNavigationDrawer extends StatelessWidget {
  const LeftNavigationDrawer({Key key}) : super(key: key);

  final String name = "Swarupananda Dhua";

  @override
  Widget build(BuildContext context) {
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
              Auth().signOut();
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('email');
              prefs.remove('uid');
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ],
      )),
    );
  }
}

import 'package:farmapp/screens/home/home.dart';
import 'package:farmapp/screens/account/account.dart';
import 'package:farmapp/screens/history/history.dart';
import 'package:flutter/material.dart';

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

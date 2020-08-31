import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Screens/Common/NavigationDrawer.dart';
import 'package:FarmApp/Screens/History/HistoryScreen.dart';
import 'package:FarmApp/Screens/PostRequirement/PostRequirementScreen.dart';
import 'package:FarmApp/Screens/Profile/ProfileUpdateScreen.dart';
import 'package:FarmApp/Screens/Search/RequirementSearch.dart';
import 'package:FarmApp/Screens/Trade/TradeScreen.dart';
import 'package:FarmApp/Screens/Home/HomeScreen.dart';
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class WrapperScreen extends StatefulWidget {
  @override
  _WrapperScreenState createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen>
    with SingleTickerProviderStateMixin {
  static List<Widget> _tabs = <Widget>[
    HomeScreen(),
    ProfileUpdateScreen(null),
    TradeScreen(),
    HistoryScreen(),
  ];
  static List<String> _titles = <String>[
    'Home',
    'Profile',
    'Trade',
    'History',
  ];
  static List<Widget> _icons = [
    Icon(
      Icons.home,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.account_circle,
      size: 30,
      color: Colors.white,
    ),
    Icon(
      Icons.import_export,
      size: 30,
      color: Colors.white,
    ),
    Icon(Icons.history, size: 30, color: Colors.white),
  ];

  TabController _tabController;

  printDeviceToken() async {
    String fcmToken = SharedPrefData.getFCMToken();

    if (fcmToken == null) {
      FirebaseMessaging fcm = FirebaseMessaging();
      fcmToken = await fcm.getToken();

      SharedPrefData.setString('fcmToken', fcmToken);
      String uid = SharedPrefData.getUid();

      Map<String, String> data = Map<String, String>();
      data['token'] = fcmToken;
      await Firestore.instance
          .collection(FIRESTORE_TOKEN_DB)
          .document(uid)
          .setData(data)
          .then(
        (doc) {
          return true;
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();

    printDeviceToken();

    _tabController = TabController(
      initialIndex: 0,
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_tabController.index]),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: RequirementSearch(),
              );
            },
          ),
        ],
      ),
      drawer: NavigationDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 16,
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PostRequirementScreen()),
          );
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.indigo,
        height: 50,
        backgroundColor: Colors.white,
        animationCurve: Curves.ease,
        animationDuration: Duration(seconds: 1),
        buttonBackgroundColor: Colors.indigo,
        items: _icons,
        onTap: (index) {
          setState(() {
            _tabController.animateTo(index);
          });
        },
      ),
      body: Container(
        color: Colors.white,
        child: TabBarView(
          children: _tabs,
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
        ),
      ),
    );
  }
}

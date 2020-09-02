import 'package:FarmApp/Models/Colors.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Common/NavigationDrawer.dart';
import 'package:FarmApp/Screens/History/HistoryScreen.dart';
import 'package:FarmApp/Screens/Trade/PostRequirementScreen.dart';
import 'package:FarmApp/Screens/Profile/ProfileUpdateScreen.dart';
import 'package:FarmApp/Screens/Search/RequirementSearch.dart';
import 'package:FarmApp/Screens/Trade/TradeScreen.dart';
import 'package:FarmApp/Screens/Home/HomeScreen.dart';
import 'package:FarmApp/Services/DBService.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  @override
  WrapperState createState() => WrapperState();
}

class WrapperState extends State<Wrapper> with SingleTickerProviderStateMixin {
  static List<Widget> tabs = <Widget>[
    HomeScreen(),
    ProfileUpdateScreen(),
    TradeScreen(),
    HistoryScreen(),
  ];
  static List<String> _titles = <String>[
    STRING_HOME,
    STRING_PROFILE,
    STRING_TRADE,
    STRING_HISTORY,
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

  TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    DBService.printDeviceToken();

    tabController = TabController(
      initialIndex: 0,
      length: tabs.length,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[tabController.index]),
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
        backgroundColor: Color(APP_COLOR),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PostRequirementScreen()),
          );
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Color(APP_COLOR),
        height: 50,
        backgroundColor: Colors.white,
        animationCurve: Curves.ease,
        animationDuration: Duration(seconds: 1),
        buttonBackgroundColor: Color(APP_COLOR),
        items: _icons,
        onTap: (index) => setState(() => tabController.animateTo(index)),
      ),
      body: Container(
        color: Colors.white,
        child: TabBarView(
          children: tabs,
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
        ),
      ),
    );
  }
}

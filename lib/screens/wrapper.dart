import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:farmapp/screens/account/account.dart';
import 'package:farmapp/screens/common/navigation_drawer.dart';
import 'package:farmapp/screens/history/history.dart';
import 'package:farmapp/screens/post_requirement/post_requirement.dart';
import 'package:farmapp/screens/search/requirement_search.dart';
import 'package:farmapp/screens/trade/trade.dart';
import 'package:farmapp/screens/home/home.dart';
import 'package:flutter/material.dart';

class WrapperScreen extends StatefulWidget {
  @override
  _WrapperScreenState createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen>
    with SingleTickerProviderStateMixin {
  static List<Widget> _tabs = <Widget>[
    HomeScreen(),
    AccountScreen(),
    TradeScreen(),
    HistoryScreen(),
  ];
  static List<String> _titles = <String>[
    'Home',
    'Account',
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
  @override
  void initState() {
    super.initState();
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
        elevation: 16.0,
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostRequirementScreen()),
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

import 'package:farmapp/screens/account/account.dart';
import 'package:farmapp/screens/common/navigation_drawer.dart';
import 'package:farmapp/screens/history/history.dart';
import 'package:farmapp/screens/post_requirement/post_requirement.dart';
import 'package:farmapp/screens/search/requirement_search.dart';
import 'package:farmapp/screens/trade/trade.dart';
import 'package:farmapp/screens/home/home.dart';
import 'package:flutter/material.dart';

class WrapperScreen extends StatefulWidget {
  final int tabIndex;
  WrapperScreen({this.tabIndex});

  @override
  _WrapperScreenState createState() => _WrapperScreenState(tabIndex);
}

class _WrapperScreenState extends State<WrapperScreen> {
  int _tabIndex;
  static List<Widget> _tabs = <Widget>[
    HomeScreen(),
    AccountScreen(),
    TradeScreen(),
    HistoryScreen(),
  ];
  static List<String> _titles = <String>[
    "Home",
    "Account",
    "Trade",
    "History",
  ];

  _WrapperScreenState(this._tabIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_tabIndex]),
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
      bottomNavigationBar: BottomNavigationBar(
        elevation: 16.0,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(_titles[0]),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text(_titles[1]),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.import_export),
            title: Text(_titles[2]),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text(_titles[3]),
          ),
        ],
        currentIndex: _tabIndex,
        fixedColor: Colors.indigo,
        onTap: onBottomNavigationTapped,
      ),
      body: _tabs[_tabIndex],
    );
  }

  void onBottomNavigationTapped(int value) {
    setState(() {
      _tabIndex = value;
    });
  }
}

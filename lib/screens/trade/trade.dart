import 'package:farmapp/screens/common/bottom_navigation_bar.dart';
import 'package:farmapp/screens/common/left_navigation_drawer.dart';
import 'package:flutter/material.dart';

class TradeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TradeScreenState();
}

class TradeScreenState extends State<TradeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FarmApp')),
      drawer: LeftNavigationDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 16.0,
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
        onPressed: () {
          print('FAB Pressed');
        },
      ),
      body: Center(
        child: Text('TODO'),
      ),
      bottomNavigationBar: BotNavBar(botNavBarIdx: 2),
    );
  }
}

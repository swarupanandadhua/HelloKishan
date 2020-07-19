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
      body: Center(
        child: Text('TODO'),
      ),
      bottomNavigationBar: BotNavBar(botNavBarIdx: 2),
    );
  }
}

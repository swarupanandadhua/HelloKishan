import 'package:farmapp/screens/authenticate/signIn.dart';
import 'package:farmapp/services/auth.dart';
import 'package:flutter/material.dart';
import '../../common.dart';

class HomeScreen2 extends StatelessWidget {

  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FarmApp'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person, color: Colors.white,),
            label: Text('Logout', style: TextStyle(color: Colors.white),),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      drawer: LeftNavigationDrawer(),
      body: Center(
        child: Text(
            'Signed In'
        ),
      ),
      bottomNavigationBar: BotNavBar(botNavBarIdx: 0),
    );
  }
}

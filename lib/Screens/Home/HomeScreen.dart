import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    key,
  }) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 80,
            child: ListView.builder(
              itemBuilder: (_, i) {
                return Container(
                  child: Image.asset(APP_LOGO),
                  height: 50,
                  width: 50,
                );
              },
              itemCount: 10,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            // TODO 2: Remove this debug button after resolving TODO 1
            height: 50,
            child: RaisedButton(
              child: Text('Debug Print User'),
              onPressed: () async {
                debugPrint(
                    'Actual: ' + FirebaseAuth.instance.currentUser.toString());
                User u = Provider.of<User>(context, listen: false);
                debugPrint("Provider:" + u.toString());
                debugPrint("Pref: " + SharedPrefData.getUid().toString());
              },
            ),
            margin: EdgeInsets.only(top: 20.0),
          ),
        ],
      ),
    );
  }
}

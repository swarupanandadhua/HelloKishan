import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO 2: Remove this debug button after resolving TODO 1
Widget debugPrintUserButton(BuildContext context) {
  return Container(
    height: 50,
    child: RaisedButton(
      child: Text('Debug Print User'),
      onPressed: () async {
        debugPrint('Actual: ' + FirebaseAuth.instance.currentUser.toString());
        User u = Provider.of<User>(context, listen: false);
        debugPrint("Provider:" + u.toString());
        debugPrint("Pref: " + SharedPrefData.getUid().toString());
      },
    ),
    margin: EdgeInsets.only(top: 20.0),
  );
}

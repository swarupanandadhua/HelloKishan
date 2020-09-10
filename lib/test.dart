import 'package:FarmApp/Screens/Trade/TradeTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/firestore_ui.dart';

import 'Models/Models.dart' as FarmApp;

import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TestScreenState();
}

class TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirestoreAnimatedList(
        // TODO: IMPORTANT: Use FirestoreAnimatedList everywhere
        // TODO: IMPORTANT: Pagination of Firestore data
        query: FirebaseFirestore.instance.collection('fuck'),
        padding: EdgeInsets.all(8.0),
        itemBuilder: (_, snap, animation, int i) => TradeTile(
          FarmApp.Transaction.fromMap(snap.id, snap.data()),
        ),
        emptyChild: Center(
          child: Text('Nothing'),
        ),
      ),
    );
  }
}

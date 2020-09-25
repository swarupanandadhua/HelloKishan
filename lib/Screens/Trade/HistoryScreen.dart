import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Models/Styles.dart';
import 'package:FarmApp/Models/Models.dart' as FarmApp;
import 'package:FarmApp/Screens/Trade/TradeTile.dart';
import 'package:FarmApp/Services/DBService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// COVERITY: Trade & History Screen can be shared (TODO:ARPITA)

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DBService.historyScreenQ.snapshots(),
      builder: (_, AsyncSnapshot<QuerySnapshot> snap) {
        if (snap.hasData) {
          if (snap.data.docs.length > 0) {
            return ListView.builder(
              itemCount: snap.data.docs.length,
              itemBuilder: (_, i) {
                return TradeTile(
                  FarmApp.Transaction.fromMap(
                    snap.data.docs[i].id,
                    snap.data.docs[i].data(),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                STRING_NO_TRANSACTIONS_FOUND,
                style: style1,
              ),
            );
          }
        } else if (snap.hasError) {
          return Center(
            child: Text(
              STRING_WENT_WRONG,
              style: style1,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

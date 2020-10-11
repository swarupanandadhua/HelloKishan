import 'package:HelloKishan/Models/Strings.dart';
import 'package:HelloKishan/Models/Styles.dart';
import 'package:HelloKishan/Models/Models.dart' as HelloKishan;
import 'package:HelloKishan/Screens/Trade/TradeTile.dart';
import 'package:HelloKishan/Services/DBService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
                  HelloKishan.Transaction.fromMap(
                    snap.data.docs[i].id,
                    snap.data.docs[i].data(),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                STRING_NO_TRANSACTIONS_FOUND.tr(),
                style: style1,
              ),
            );
          }
        } else if (snap.hasError) {
          return Center(
            child: Text(
              STRING_WENT_WRONG.tr(),
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

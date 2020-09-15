import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Models/Styles.dart';
import 'package:FarmApp/Screens/Trade/TradeTile.dart';
import 'package:FarmApp/Services/DBService.dart';
import 'package:firestore_ui/firestore_ui.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return FirestoreAnimatedList(
      query: DBService.historyScreenQ,
      itemBuilder: (_, snap, animation, int i) {
        return TradeTile(
          Transaction.fromMap(snap.id, snap.data()),
        );
      },
      emptyChild: Center(
        child: Text(
          STRING_NO_TRANSACTIONS_FOUND,
          style: style1,
        ),
      ),
      errorChild: Center(
        child: Text(
          STRING_SOMETHING_WENT_WRONG,
          style: style1,
        ),
      ),
      defaultChild: Center(child: CircularProgressIndicator()),
    );
  }
}

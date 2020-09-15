import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Common/Styles.dart';
import 'package:FarmApp/Screens/Trade/MyRequirementTile.dart';
import 'package:FarmApp/Services/DBService.dart';
import 'package:firestore_ui/firestore_ui.dart';
import 'package:flutter/material.dart';

class MyRequirementScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyRequirementScreenState();
}

class MyRequirementScreenState extends State<MyRequirementScreen> {
  @override
  Widget build(BuildContext context) {
    return FirestoreAnimatedList(
      query: DBService.historyScreenQ,
      itemBuilder: (_, snap, animation, int i) {
        return MyRequirementTile(
          Requirement.fromMap(snap.id, snap.data()),
        );
      },
      emptyChild: Center(
        child: Text(
          STRING_NO_REQUIREMENTS_FOUND,
          style: style1,
        ),
      ),
      errorChild: Center(
        child: Text(
          STRING_SOMETHING_WENT_WRONG,
          style: style1,
        ),
      ),
    );
  }
}

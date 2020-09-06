import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Trade/MyRequirementTile.dart';
import 'package:FarmApp/Services/DBService.dart';
import 'package:flutter/material.dart';

class MyRequirementScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyRequirementScreenState();
}

class MyRequirementScreenState extends State<MyRequirementScreen> {
  Stream<List<Requirement>> requirements;

  @override
  void initState() {
    super.initState();
    requirements = DBService.fetchMyRequirements();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Requirement>>(
      stream: requirements,
      builder: (_, snap) {
        if (snap.hasData) {
          if (snap.data.length > 0) {
            return Container(
              color: Color(0xff0011),
              child: ListView.builder(
                itemBuilder: (_, i) {
                  return MyRequirementTile(snap.data[i]);
                },
                itemCount: snap.data.length,
              ),
            );
          } else {
            return Center(
              child: Text(STRING_NO_REQUIREMENTS_FOUND),
            );
          }
        } else if (snap.hasError) {
          return Center(
            child: Text(STRING_SOMETHING_WENT_WRONG),
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

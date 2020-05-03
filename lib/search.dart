import 'package:flutter/material.dart';
import 'package:farmapp/models/models.dart';
import 'package:farmapp/services/tmp.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Requirement> requirementList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () async {
          quickSignIn();
          fetchRequirements(requirementList);
        },
      ),
    );
  }
}

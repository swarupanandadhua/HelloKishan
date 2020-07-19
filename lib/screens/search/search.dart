import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:farmapp/models/models.dart';
import 'package:farmapp/services/tmp.dart';
import 'package:farmapp/assets/data/constants.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Requirement> requirementList = List<Requirement>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRequirements();
  }

  void fetchRequirements() async {
    String signin = await quickSignIn();
    if (signin != null) {
      await Firestore.instance
          .collection('requirement')
          .getDocuments()
          .then((snapshot) {
        snapshot.documents.forEach((doc) {
          Requirement r = Requirement(
            uid: doc["user"],
          );
          r.profilePictureUrl = FIREBASE_BASE_URL + "/user/U00000.jpg";
          print(r.uid);
          setState(() {
            requirementList.insert(0, r);
          });
        });
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator()
        : Container(
            child: ListView.builder(
              itemBuilder: buildSearchItemTile,
              itemCount: requirementList.length,
            ),
          );
  }

  Widget buildSearchItemTile(BuildContext ctxt, int i) {
    Requirement r = requirementList.elementAt(i);
    return Container(
      child: Column(
        children: <Widget>[
          Image(
            image: FirebaseImage(r.profilePictureUrl),
            height: 200,
            width: 200,
          ),
          Text(r.uid),
        ],
      ),
    );
  }
}

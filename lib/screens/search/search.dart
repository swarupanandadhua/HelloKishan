import 'package:farmapp/services/database.dart';
import 'package:farmapp/services/location.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:farmapp/screens/common/bottom_navigation_bar.dart';
import 'package:farmapp/screens/common/left_navigation_drawer.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:farmapp/models/models.dart';

class SearchScreen extends StatefulWidget {
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  List<Requirement> requirementList = List<Requirement>();
  bool isRequirementsLoading = true;

  bool isLocationLoading = true;
  Position currentLocation;

  @override
  void initState() {
    super.initState();

    setState(() async {
      requirementList = await fetchRequirements();
      isRequirementsLoading = false;
    });

    setState(() async {
      currentLocation = await fetchLocation();
      isLocationLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Serach Results')),
      drawer: LeftNavigationDrawer(),
      body: isRequirementsLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Color(0xff0011),
              child: ListView.builder(
                itemBuilder: buildSearchItemTile,
                itemCount: requirementList.length,
              ),
            ),
      bottomNavigationBar: BotNavBar(botNavBarIdx: 0),
    );
  }

  Widget buildSearchItemTile(BuildContext ctxt, int i) {
    Requirement r = requirementList.elementAt(i);
    return Card(
      elevation: 8.0,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Image(
              image: FirebaseImage(r.userImage),
              height: 50,
              width: 50,
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                r.displayString,
                style: TextStyle(fontSize: 14),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Rate: Rs. " + r.rate + " per kg",
                style: TextStyle(fontSize: 12),
              ),
            ),
            trailing: Image(
              image: FirebaseImage(r.productImage),
              height: 50,
              width: 50,
            ),
          ),
          FlatButton(
            child: Text('Call ' + r.name),
            onPressed: () => UrlLauncher.launch('tel:' + r.mobile),
          ),
        ],
      ),
    );
  }
}

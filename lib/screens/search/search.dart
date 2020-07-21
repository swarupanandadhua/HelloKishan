import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmapp/screens/common/bottom_navigation_bar.dart';
import 'package:farmapp/screens/common/left_navigation_drawer.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:farmapp/models/models.dart';

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
    // Error handling
    // String signin = await quickSignIn();
    // if (signin != null) {
    await Firestore.instance
        .collection('requirement')
        .getDocuments()
        .then((snapshot) {
      snapshot.documents.forEach((doc) {
        int rate = doc["rate"];
        int qty = doc["qty"];
        Requirement r = Requirement(
          uid: doc["user"],
          name: doc["name"],
          mobile: doc["mobile"],
          pid: doc["product"],
          product: doc["product"],
          wantsTo: (doc["wants_to"] == "Buy") ? TradeType.BUY : TradeType.SELL,
          rate: rate.toString(),
          qty: qty.toString(),
        );
        print("uid:" + r.uid);
        print("Mobile:" + r.mobile);
        print("pid:" + r.pid);
        print("\n\n");
        setState(() {
          requirementList.insert(0, r);
        });
      });
    });
    setState(() {
      isLoading = false;
    });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Serach Results')),
      drawer: LeftNavigationDrawer(),
      body: isLoading
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

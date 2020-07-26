import 'package:farmapp/services/database.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:farmapp/screens/common/navigation_drawer.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:farmapp/models/models.dart';

class SearchScreen extends StatefulWidget {
  final String product;
  SearchScreen(this.product);

  @override
  SearchScreenState createState() => SearchScreenState(product);
}

class SearchScreenState extends State<SearchScreen> {
  final String title = 'Serach Results';
  final String product;

  Future<List<Requirement>> requirements;

  SearchScreenState(this.product);

  @override
  void initState() {
    super.initState();
    requirements = DatabaseService().fetchRequirements(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      drawer: NavigationDrawer(),
      body: FutureBuilder<List<Requirement>>(
        future: requirements,
        builder: (BuildContext ctx, AsyncSnapshot<List<Requirement>> snap) {
          if (snap.hasData) {
            if (snap.data.length > 0) {
              return Container(
                color: Color(0xff0011),
                child: ListView.builder(
                  itemBuilder: (context, i) {
                    return buildSearchItemTile(snap.data[i]);
                  },
                  itemCount: snap.data.length,
                ),
              );
            } else {
              return Center(
                child: Text("Nothing found!"),
              );
            }
          } else if (snap.hasError) {
            return Center(
              child: Text('Something went wrong!'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildSearchItemTile(Requirement r) {
    return Card(
      elevation: 8.0,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: ClipOval(
              child: Image(
                image: FirebaseImage(r.userImage),
              ),
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
            trailing: ClipOval(
              child: Image(
                image: FirebaseImage(r.productImage),
              ),
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

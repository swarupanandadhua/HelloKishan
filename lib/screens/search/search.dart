import 'package:farmapp/services/database.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:universal_html/html.dart' as HTML;
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:farmapp/screens/common/navigation_drawer.dart';
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

  Future<List<Requirement>> requirementsFuture;

  HTML.Location location;

  List<Requirement> requirements;

  SearchScreenState(this.product);

  @override
  void initState() {
    super.initState();
    requirementsFuture = DatabaseService().fetchRequirements(product);
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
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (option) {
              switch (option) {
                case 'Sort by distance':
                  debugPrint(StackTrace.current.toString());
                  break;
                case 'Highest Price First':
                  if (requirements != null) {
                    setState(() {
                      requirements.sort((a, b) => (a.rate.compareTo(b.rate)));
                    });
                  }
                  break;
                case 'Lowest Price First':
                  if (requirements != null) {
                    setState(() {
                      requirements.sort((b, a) => (a.rate.compareTo(b.rate)));
                    });
                  }
                  break;
                default:
                  debugPrint(StackTrace.current.toString());
              }
            },
            itemBuilder: (_) {
              return {
                'Sort by distance',
                'Highest Price First',
                'Lowest Price First',
              }.map((String option) {
                return PopupMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: NavigationDrawer(),
      body: FutureBuilder<List<Requirement>>(
        future: requirementsFuture,
        builder: (_, snap) {
          if (snap.hasData) {
            if (snap.data.length > 0) {
              requirements = snap.data;
              return Container(
                color: Color(0xff0011),
                child: ListView.builder(
                  itemBuilder: (_, i) {
                    return buildSearchItemTile(snap.data[i]);
                  },
                  itemCount: snap.data.length,
                ),
              );
            } else {
              return Center(
                child: Text('Nothing found!'),
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
                'Rate: Rs. ' + r.rate + ' per kg',
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

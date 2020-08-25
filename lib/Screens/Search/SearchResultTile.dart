import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Screens/Trade/SellRequestScreen.dart';
// import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class SearchResultTile extends StatelessWidget {
  final Requirement requirement;

  SearchResultTile({this.requirement});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Column(
        children: <Widget>[
          ListTile(
/*             leading: ClipOval(
              child: Image(
                image: FirebaseImage(requirement.userImage),
              ),
            ), */
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                requirement.displayString,
                style: TextStyle(fontSize: 14),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Rate: Rs. ' + requirement.rate + ' per kg',
                style: TextStyle(fontSize: 12),
              ),
            ),
/*             trailing: ClipOval(
              child: Image(
                image: FirebaseImage(requirement.productImage),
              ),
            ), */
          ),
          FlatButton(
            child: Text('Contact ' + 'NAME'), // requirement.name
            // onPressed: () => UrlLauncher.launch('tel:' + requirement.mobile),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SellRequestScreen(requirement),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

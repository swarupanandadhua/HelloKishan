import 'package:FarmApp/Models/Assets.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Screens/Trade/SellRequestScreen.dart';
import 'package:flutter/material.dart';

class SearchResultTile extends StatelessWidget {
  final Requirement requirement;

  SearchResultTile({this.requirement});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: ClipOval(
              child: Image.asset(ASSET_APP_LOGO),
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                requirement.tradeType,
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
            trailing: ClipOval(
              child: Image.asset(ASSET_APP_LOGO),
            ),
          ),
          FlatButton(
            child: Text('Contact ' + requirement.name),
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

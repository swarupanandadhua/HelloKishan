import 'package:FarmApp/Models/Assets.dart';
import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Screens/Trade/SellRequestScreen.dart';
import 'package:flutter/material.dart';

class SearchResultTile extends StatelessWidget {
  final Requirement r;

  SearchResultTile({this.r});

  @override
  Widget build(BuildContext context) {
    debugPrint('XXXXXXX: ' + r.photoURL);
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: ClipOval(
              child: Image.network(
                r.photoURL,
                loadingBuilder: (_, c, prog) {
                  return (prog == null) ? c : Image.asset(ASSET_LOADING);
                },
                errorBuilder: (_, e, stack) => Image.asset(ASSET_RED_CROSS),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                r.name +
                    ' wants to ' +
                    r.tradeType +
                    ' ' +
                    r.qty +
                    'kg ' +
                    PRODUCTS[int.parse(r.pid)][LANGUAGE.CURRENT],
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
              child: Image.asset(PRODUCTS[int.parse(r.pid)][2]),
            ),
          ),
          FlatButton(
            child: Text('Contact ' + r.name),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SellRequestScreen(r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

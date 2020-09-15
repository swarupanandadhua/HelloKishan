import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Products.dart';
import 'package:FarmApp/Screens/Common/LoadingScreen.dart';
import 'package:FarmApp/Screens/Trade/SellRequestScreen.dart';
import 'package:flutter/material.dart';

class SearchResultTile extends StatelessWidget {
  final Requirement r;

  SearchResultTile({this.r});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Container(
              height: 50,
              width: 50,
              child: ClipOval(
                child: Image.network(
                  r.photoURL,
                  loadingBuilder: (_, c, p) =>
                      (p == null) ? c : ImageAsset.loading,
                  errorBuilder: (_, e, stack) => ImageAsset.account,
                ),
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
            trailing: Container(
              height: 50,
              width: 50,
              child: ClipOval(
                child: Image.asset(PRODUCTS[int.parse(r.pid)][2]),
              ),
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

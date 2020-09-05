import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Products.dart';
import 'package:flutter/material.dart';

class MyRequirementTile extends StatefulWidget {
  final Requirement r;

  MyRequirementTile(this.r);

  @override
  MyRequirementTileState createState() => MyRequirementTileState(r);
}

class MyRequirementTileState extends State<MyRequirementTile> {
  Requirement r;

  MyRequirementTileState(this.r);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Image.asset(
                    PRODUCTS[int.parse(r.pid)][2],
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Product : ' +
                          PRODUCTS[int.parse(r.pid)][LANGUAGE.CURRENT]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Rate : Rs. ${r.rate} per kg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Qty : ${r.qty} kg'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton.icon(
                  onPressed: () => debugPrint('TODO'),
                  icon: Icon(Icons.delete),
                  label: Text('DELETE'),
                ),
                RaisedButton.icon(
                  onPressed: () => debugPrint('TODO'),
                  icon: Icon(Icons.edit),
                  label: Text('UPDATE'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

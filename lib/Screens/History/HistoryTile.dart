import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';

class HistoryTile extends StatelessWidget {
  final Transaction transaction;

  HistoryTile({this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Image(
                    image: FirebaseImage(transaction.secondPartyPhotoUrl),
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    (transaction.type == TradeType.BUY)
                        ? STRING_BOUGHT_FROM
                        : STRING_SOLD_TO,
                    style: TextStyle(
                      color: Colors.grey[350],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    transaction.secondPartyName,
                    style: TextStyle(color: Colors.black87, fontSize: 20.0),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Image(
                    image: FirebaseImage(transaction.productPhotoUrl),
                    height: 50.0,
                    width: 50.0,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey[600],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('$STRING_RATE : ₹${transaction.rate}/kg'),
                  Text('$STRING_QUANTITY: ${transaction.qty} kg'),
                  Text('$STRING_TOTAL_AMOUNT: ₹${transaction.amt}'),
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.grey[600],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(transaction.timestamp.toString()),
              Icon(Icons.check),
            ],
          ),
        ],
      ),
    );
  }
}

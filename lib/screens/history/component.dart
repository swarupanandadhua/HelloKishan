import 'package:farmapp/models/models.dart';
import 'package:flutter/material.dart';

class HistoryTile extends StatelessWidget {
  final Transaction data;

  HistoryTile({@required this.data, Key key}) : assert(data != null);

  @override
  Widget build(BuildContext context) {
    String rateText = 'rate: ₹${data.rate}/kg';
    String qtyText = 'qty: ${data.qty}kg';
    String amountText = 'amount: ₹${data.rate * data.qty}';
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        elevation: 8.0,
        child: Container(
          height: 264.0,
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.account_circle),
                      iconSize: 60.0,
                      onPressed: null,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 30.0, 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Sold to',
                            style: TextStyle(
                                color: Colors.grey[350],
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            data.secondPartyName,
                            style: TextStyle(
                                color: Colors.grey[800], fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: Divider(
                    color: Colors.grey[600],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(52.0, 0.0, 10.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            rateText,
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            qtyText,
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            amountText,
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 12.0),
                      child: SizedBox(
                        height: 92,
                        child: Image.asset(
                          'images/app_logo.jpg',
                          height: 68,
                          width: 68,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: Divider(
                    color: Colors.grey[600],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 4.0, 72.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Delivery Date'),
                      SizedBox(
                        width: 32,
                      ),
                      Icon(Icons.check),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

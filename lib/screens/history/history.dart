import 'package:farmapp/models/models.dart';
import 'package:farmapp/services/database.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  Future<List<Transaction>> transactions;

  @override
  void initState() {
    super.initState();
    transactions = DatabaseService().fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Transaction>>(
      future: transactions,
      builder: (BuildContext ctx, AsyncSnapshot<List<Transaction>> snap) {
        if (snap.hasData) {
          if (snap.data.length > 0) {
            return Container(
              color: Color(0xff0011),
              child: ListView.builder(
                itemBuilder: (context, i) {
                  return _buildHistoryTile(snap.data[i]);
                },
                itemCount: snap.data.length,
              ),
            );
          } else {
            return Center(
              child: Text('No transactions found!'),
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
    );
  }

  Widget _buildHistoryTile(Transaction t) {
    return Card(
      color: Colors.white,
      elevation: 8.0,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Image(
                    image: FirebaseImage(t.secondPartyImageUrl),
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
                    (t.type == TradeType.BUY) ? 'Bought from' : 'Sold to',
                    style: TextStyle(
                      color: Colors.grey[350],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    t.secondPartyName,
                    style: TextStyle(color: Colors.black87, fontSize: 20.0),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Image(
                    image: FirebaseImage(t.productImageUrl),
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
                  Text('Rate : ₹${t.rate}/kg'),
                  Text('Quantity: ${t.qty}kg'),
                  Text('Total Amount: ₹${t.rate * t.qty}'),
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
              Text(t.timestamp.toString()),
              Icon(Icons.check),
            ],
          ),
        ],
      ),
    );
  }
}

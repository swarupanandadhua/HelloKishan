import 'package:farmapp/screens/common/bottom_navigation_bar.dart';
import 'package:farmapp/screens/common/left_navigation_drawer.dart';
import 'package:farmapp/models/models.dart';
import 'package:farmapp/services/database.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  List<Transaction> transactions = List<Transaction>();
  String dataLoadingStatus = "UNKNOWN";

  @override
  void initState() async {
    super.initState();

    setState(() async {
      dataLoadingStatus = "LOADED";
      transactions = await fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FarmApp'),
      ),
      drawer: LeftNavigationDrawer(),
      body: _historyScreenBody(),
      bottomNavigationBar: BotNavBar(botNavBarIdx: 3),
    );
  }

  _historyScreenBody() {
    if (dataLoadingStatus == "UNKNOWN") {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (dataLoadingStatus == "LOADED" && transactions.length > 0) {
      return Center(
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: _buildHistoryTile,
        ),
      );
    } else {
      return Center(
        child: Text("No transactions yet!"),
      );
    }
  }

  Widget _buildHistoryTile(BuildContext contet, int i) {
    Transaction transaction = transactions.elementAt(i);

    return Card(
      color: Colors.white,
      elevation: 8.0,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image(
                image: FirebaseImage(transaction.secondPartyImageUrl),
                height: 50,
                width: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sold to',
                    style: TextStyle(
                        color: Colors.grey[350], fontWeight: FontWeight.w500),
                  ),
                  Text(
                    transaction.secondPartyName,
                    style: TextStyle(color: Colors.grey[800], fontSize: 20.0),
                  ),
                ],
              ),
              Image(
                image: FirebaseImage(transaction.productImageUrl),
                height: 50,
                width: 50,
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
                  Text('Rate : ₹${transaction.rate}/kg'),
                  Text('Quantity: ${transaction.qty}kg'),
                  Text('Total Amount: ₹${transaction.rate * transaction.qty}')
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

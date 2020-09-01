import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Screens/Trade/TradeTile.dart';
import 'package:FarmApp/Services/DatabaseService.dart';
import 'package:flutter/material.dart';

class TradeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TradeScreenState();
}

class TradeScreenState extends State<TradeScreen> {
  Future<List<Transaction>> transactions;

  @override
  void initState() {
    super.initState();
    transactions = DatabaseService.fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Transaction>>(
      future: transactions,
      builder: (_, snap) {
        if (snap.hasData) {
          if (snap.data.length > 0) {
            return Container(
              color: Color(0xff0011),
              child: ListView.builder(
                itemBuilder: (_, i) {
                  return TradeTile(transaction: snap.data[i]);
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
}

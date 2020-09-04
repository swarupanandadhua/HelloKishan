import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Trade/TradeTile.dart';
import 'package:FarmApp/Services/DBService.dart';
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
    transactions = DBService.fetchTransactions('TRADE');
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
                  return TradeTile(snap.data[i]);
                },
                itemCount: snap.data.length,
              ),
            );
          } else {
            return Center(
              child: Text(STRING_NO_TRANSACTIONS_FOUND),
            );
          }
        } else if (snap.hasError) {
          return Center(
            child: Text(STRING_SOMETHING_WENT_WRONG),
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

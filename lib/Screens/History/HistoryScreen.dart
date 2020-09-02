import 'package:FarmApp/Models/Models.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/History/HistoryTile.dart';
import 'package:FarmApp/Services/DBService.dart';
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
    transactions = DBService.fetchTransactions();
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
                  return HistoryTile(transaction: snap.data[i]);
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

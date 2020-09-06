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
  Stream<List<Transaction>> transactions;

  @override
  void initState() {
    super.initState();
    transactions = DBService.fetchTransactionsStream('TRADE');
  }

  @override
  Widget build(BuildContext context) {
    return /* AnimatedStreamList(
      streamList: transactions,
      itemBuilder: (t, i, _, animation) => SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: TradeTile(t),
      ),
      itemRemovedBuilder: (t, i, _, animation) => SizeTransition(
        axis: Axis.horizontal,
        sizeFactor: animation,
        child: TradeTile(t),
      ),
    ); */
        StreamBuilder<List<Transaction>>(
      stream: transactions,
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

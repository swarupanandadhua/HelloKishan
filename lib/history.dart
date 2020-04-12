import 'dart:io';

import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryScreenState();
}

enum TransactionStatus {
  SUCCESSFUL,
  FAILED, // Technical Error
  WAITING,
  DECLINED, // Rejected by Other Party
  CANCELLED // Changed Mind
}

enum TransactionType { SELL, BUY }

class Transaction {
  String otherPartyIconUrl;
  String otherPartyName;
  String otherPartyNick;

  String timestamp;

  TransactionType type;
  TransactionStatus status;

  String prodIconURL;

  String rate;
  String qty;
  String amt;
}

class HistoryScreenState extends State<HistoryScreen> {
  Future<List<Transaction>> getTransactions() async {
    sleep(Duration(seconds: 2));

    for (int i = 0; i < 5; i++) {
      transactions.insert(
        i,
        Transaction(),
      );
    }
    return transactions;
  }

  List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    getTransactions();

    return Container(
      child: ListView(
        children: <Widget>[],
      ),
    );
  }
}

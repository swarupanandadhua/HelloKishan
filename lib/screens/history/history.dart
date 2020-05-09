import 'dart:io';

import 'package:farmapp/common.dart';
import 'package:farmapp/screens/history/component.dart';
import 'package:farmapp/models/models.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  Transaction temp = Transaction(
    secondPartyName: 'Rahul Shaikh',
    qty: 10,
    rate: 10.0,
  );
  var datas = <Transaction>[
    Transaction(
      secondPartyName: 'Buyer 1',
      qty: 10,
      rate: 10.0,
    ),
    Transaction(
      secondPartyName: 'Buyer 2',
      qty: 20,
      rate: 50.0,
    ),
    Transaction(
      secondPartyName: 'Buyer 3',
      qty: 12,
      rate: 5.0,
    ),
    Transaction(
      secondPartyName: 'Buyer 20',
      qty: 12,
      rate: 5.0,
    ),
  ];

  Future<List<Transaction>> getTransactions() async {
    sleep(Duration(seconds: 2));

    for (int i = 0; i < 5; i++) {
      transactions.insert(i, Transaction());
    }
    return transactions;
  }

  List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farm App'),
      ),
      drawer: LeftNavigationDrawer(),
      body: Center(
        child: ListView.builder(
          itemCount: datas.length,
          itemBuilder: _buildHistoryListItem,
        ),
      ),
      bottomNavigationBar: BotNavBar(botNavBarIdx: 3),
    );
  }

  Widget _buildHistoryListItem(BuildContext context, int i) {
    return HistoryTile(data: datas[i]);
  }
}

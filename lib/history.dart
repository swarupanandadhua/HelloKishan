import 'dart:io';
import 'package:farmapp/models/transaction.dart';
import 'package:flutter/material.dart';
import 'components/historyComponent.dart';
import 'common.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  HistoryData temp = HistoryData(
      buyer: 'Rahul Shaikh',
      date: DateTime.now(),
      productIcon: '...',
      qty: 10,
      rate: 10.0,
      sellerIcon: '...');
  var datas = <HistoryData>[
    HistoryData(
        buyer: 'Buyer 1',
        date: DateTime.now(),
        productIcon: '...',
        qty: 10,
        rate: 10.0,
        sellerIcon: '...'),
    HistoryData(
        buyer: 'Buyer 2',
        date: DateTime.now(),
        productIcon: '...',
        qty: 20,
        rate: 50.0,
        sellerIcon: '...'),
    HistoryData(
        buyer: 'Buyer 3',
        date: DateTime.now(),
        productIcon: '...',
        qty: 12,
        rate: 5.0,
        sellerIcon: '...'),
    HistoryData(
        buyer: 'Buyer 20',
        date: DateTime.now(),
        productIcon: '...',
        qty: 12,
        rate: 5.0,
        sellerIcon: '...'),
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

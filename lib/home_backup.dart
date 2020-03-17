import 'package:farmapp/common.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({
    this.title,
    key,
  }) : super(key: key);

  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class Buyer {
  String name;
  String nickName;
  String productName;
  double requirement;
  double price;

  Buyer(
    this.name,
    this.nickName,
    this.productName,
    this.requirement,
    this.price,
  );
}

class HomeScreenState extends State<HomeScreen> {
  var buyerList = new List();

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 12; i++) {
      buyerList.insert(
        i,
        Buyer(
          'Buyer Name $i',
          'Nick$i',
          'Carrot',
          16.0 * (i + 1),
          15.0 + i - (i % 3),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('FarmApp'),
      ),
      drawer: LeftNavigationDrawer(),
      body: Center(
        child: Scaffold(
          body: Center(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, position) {
                return SellerCard(position);
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: BotNavBar(botNavBarIdx: 0),
    );
  }
}

class SellerCard extends StatelessWidget {
  final int position;
  SellerCard(this.position, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Swarupananda Dhua(Toton)'),
              subtitle: Text('Avaiable: > 50kg, Price: INR 50'),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                    child: const Text('BUY'),
                    onPressed: () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: const Text('BUY Clicked'),
                      ));
                    }),
                FlatButton(
                  child: const Text('CALL'),
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: const Text('CALL Clicked'),
                    ));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

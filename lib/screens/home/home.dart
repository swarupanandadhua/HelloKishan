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

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FarmApp'),
      ),
      drawer: LeftNavigationDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 16.0,
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
        onPressed: () {
          print('FAB Pressed');
        },
      ),
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

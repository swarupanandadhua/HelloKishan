import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    key,
  }) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, i) {
        return Container(
          child: Image.asset('assets/images/app_logo.jpg'),
          height: 50,
          width: 50,
        );
      },
      itemCount: 10,
      scrollDirection: Axis.horizontal,
    );
  }
}

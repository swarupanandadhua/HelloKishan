import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends AppBar {
  Widget build(BuildContext context) {
    return FloatingSearchBar.builder(
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Text(index.toString()),
        );
      },
      trailing: CircleAvatar(
        child: Text("FA"),
      ),
      drawer: Drawer(
        child: Container(),
      ),
      onChanged: (String value) {},
      onTap: () {},
      decoration: InputDecoration.collapsed(
        hintText: "Search...",
      ),
    );
  }
}

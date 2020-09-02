import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Common/NavigationDrawer.dart';
import 'package:FarmApp/Screens/Search/SearchResultTile.dart';
import 'package:FarmApp/Services/DBService.dart';
import 'package:FarmApp/Models/Models.dart';
import 'package:universal_html/html.dart' as HTML;
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final String product;
  SearchScreen(this.product);

  @override
  SearchScreenState createState() => SearchScreenState(product);
}

class SearchScreenState extends State<SearchScreen> {
  SearchScreenState(this.product);

  final String product;
  Future<List<Requirement>> requirementsFuture;
  HTML.Location location; // TODO
  List<Requirement> requirements;

  @override
  void initState() {
    requirementsFuture = DBService.fetchRequirements(product);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(STRING_SEARCH_RESULTS),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (option) {
              switch (option) {
                case STRING_SORT_BY_DISTANCE:
                  debugPrint(StackTrace.current.toString());
                  break;
                case STRING_HIGHEST_PRICE_FIRST:
                  if (requirements != null) {
                    setState(() {
                      requirements.sort((a, b) => (a.rate.compareTo(b.rate)));
                    });
                  }
                  break;
                case STRING_LOWEST_PRICE_FIRST:
                  if (requirements != null) {
                    setState(() {
                      requirements.sort((b, a) => (a.rate.compareTo(b.rate)));
                    });
                  }
                  break;
                default:
                  debugPrint(StackTrace.current.toString());
              }
            },
            itemBuilder: (_) {
              return {
                STRING_SORT_BY_DISTANCE,
                STRING_HIGHEST_PRICE_FIRST,
                STRING_LOWEST_PRICE_FIRST,
              }.map((String option) {
                return PopupMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: NavigationDrawer(),
      body: FutureBuilder<List<Requirement>>(
        future: requirementsFuture,
        builder: (_, snap) {
          debugPrint(snap.toString());
          if (snap.hasData && snap.data != null) {
            if (snap.data.length > 0) {
              requirements = snap.data;
              return Container(
                color: Color(0xff0011),
                child: ListView.builder(
                  itemBuilder: (_, i) {
                    return SearchResultTile(requirement: snap.data[i]);
                  },
                  itemCount: snap.data.length,
                ),
              );
            } else {
              return Center(
                child: Text(STRING_NOTHING_FOUND),
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
      ),
    );
  }
}

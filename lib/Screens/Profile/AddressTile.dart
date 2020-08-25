import 'package:FarmApp/Models/Models.dart';
import 'package:flutter/material.dart';

class AddressTile extends StatelessWidget {
  final Address address;
  AddressTile({this.address});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle1 = TextStyle(
      color: Colors.black87,
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    );

    TextStyle textStyle2 = TextStyle(
      color: Colors.black45,
      fontSize: 13.0,
      letterSpacing: 0.5,
    );

    return Container(
      height: 200.0,
      margin: EdgeInsets.all(7.0),
      child: Card(
        elevation: 3.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 12.0, top: 5.0, bottom: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        address.name,
                        style: textStyle1,
                      ),
                      VerticalDivider(),
                      Text(
                        address.line1,
                        style: textStyle2,
                      ),
                      VerticalDivider(),
                      Text(
                        address.line2,
                        style: textStyle2,
                      ),
                      VerticalDivider(),
                      Text(
                        address.line3,
                        style: textStyle2,
                      ),
                      VerticalDivider(),
                      Text(
                        address.state + ' ' + address.postalCode,
                        style: textStyle2,
                      ),
                      VerticalDivider(),
                      Text(
                        address.country,
                        style: textStyle2,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Delivery Address',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black26,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 3.0),
                            ),
                            Checkbox(
                              value: true,
                              onChanged: null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.more_vert),
                color: Colors.black38,
                onPressed: () => debugPrint(StackTrace.current.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

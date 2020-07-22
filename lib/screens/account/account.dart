import 'package:farmapp/models/models.dart';
import 'package:farmapp/screens/common/bottom_navigation_bar.dart';
import 'package:farmapp/screens/common/left_navigation_drawer.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  String name = 'Swarupananda Dhua';
  String mob = '9609750449';
  String email = 'swarupanandadhua@gmail.com';

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<FirebaseUser>(context);
    // print(user);
    final User u = User();
    print(u.imageUrl);
    bool checkboxValueA = true;
    bool checkboxValueB = false;
    bool checkboxValueC = false;

    //List<address> addresLst = loadAddress() as List<address> ;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: LeftNavigationDrawer(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(7.0),
                alignment: Alignment.topCenter,
                child: Card(
                  elevation: 4.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(7.0),
                        alignment: Alignment.topCenter,
                        child: ClipOval(
                          child: Image(
                            width: 100.0,
                            height: 100.0,
                            image: FirebaseImage(u.imageUrl),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () => print(StackTrace.current),
                        child: Text(
                          'Change',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.blueAccent,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(name),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(u.mobile),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(u.email),
                                )
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              color: Colors.blueAccent,
                              onPressed: () => print(StackTrace.current),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 12.0,
                  top: 5.0,
                  right: 0.0,
                  bottom: 5.0,
                ),
                child: Text(
                  'Addresses',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Container(
                height: 165.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      height: 165.0,
                      width: 305.0,
                      margin: EdgeInsets.all(7.0),
                      child: Card(
                        elevation: 3.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 12.0,
                                    top: 5.0,
                                    right: 0.0,
                                    bottom: 5.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Swarupananda Dhua Overflowed',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      _verticalDivider(),
                                      Text(
                                        '16th D Cross Road',
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      _verticalDivider(),
                                      Text(
                                        'PAI Layout',
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      _verticalDivider(),
                                      Text(
                                        'Bangalore 560016',
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 00.0,
                                          top: 05.0,
                                          right: 0.0,
                                          bottom: 5.0,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Delivery Address',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black26,
                                              ),
                                            ),
                                            _verticalD(),
                                            Checkbox(
                                              value: checkboxValueA,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  checkboxValueA = value;
                                                });
                                              },
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
                                icon: Icon(
                                  Icons.more_vert,
                                ),
                                color: Colors.black38,
                                onPressed: null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 130.0,
                      width: 305.0,
                      margin: EdgeInsets.all(7.0),
                      child: Card(
                        elevation: 3.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 12.0,
                                    top: 5.0,
                                    right: 0.0,
                                    bottom: 5.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Swarupananda Dhua',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      _verticalDivider(),
                                      Text(
                                        '16th D Cross Road',
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      _verticalDivider(),
                                      Text(
                                        'PAI Layout',
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      _verticalDivider(),
                                      Text(
                                        'Bangalore 560016',
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 00.0,
                                          top: 05.0,
                                          right: 0.0,
                                          bottom: 5.0,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Delivery Address',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black12,
                                              ),
                                            ),
                                            _verticalD(),
                                            Checkbox(
                                              value: checkboxValueB,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  checkboxValueB = value;
                                                });
                                              },
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
                                icon: Icon(
                                  Icons.more_vert,
                                ),
                                color: Colors.black38,
                                onPressed: null,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 130.0,
                      width: 305.0,
                      margin: EdgeInsets.all(7.0),
                      child: Card(
                        elevation: 3.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 12.0,
                                    top: 5.0,
                                    right: 0.0,
                                    bottom: 5.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Swarupananda Dhua',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      _verticalDivider(),
                                      Text(
                                        '16th D Cross Road',
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      _verticalDivider(),
                                      Text(
                                        'PAI Layout',
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      _verticalDivider(),
                                      Text(
                                        'Bangalore 560016',
                                        style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 00.0,
                                          top: 05.0,
                                          right: 0.0,
                                          bottom: 5.0,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Delivery Address',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.black12,
                                              ),
                                            ),
                                            _verticalD(),
                                            Checkbox(
                                              value: checkboxValueC,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  checkboxValueC = value;
                                                });
                                              },
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
                                icon: Icon(
                                  Icons.more_vert,
                                ),
                                color: Colors.black38,
                                onPressed: null,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(7.0),
                child: Card(
                  elevation: 1.0,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.vpn_key,
                        ),
                        onPressed: null,
                      ),
                      _verticalD(),
                      Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(7.0),
                child: Card(
                  elevation: 1.0,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.history,
                        ),
                        onPressed: null,
                      ),
                      _verticalD(),
                      Text(
                        'Clear History',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(7.0),
                child: Card(
                  elevation: 1.0,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.do_not_disturb_on,
                        ),
                        onPressed: null,
                      ),
                      _verticalD(),
                      Text(
                        'Deactivate Account',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BotNavBar(botNavBarIdx: 1),
    );
  }

  _verticalD() {
    return Container(
      margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
    );
  }

  _verticalDivider() => Container(
        padding: EdgeInsets.all(2.0),
      );
}

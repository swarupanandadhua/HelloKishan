import 'package:farmapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  FirebaseUser u;
  Future<String> imageUrl;

  @override
  void initState() {
    u = Provider.of<FirebaseUser>(context, listen: false);
    assert(u != null);
    imageUrl = DatabaseService().getImageUrl(u.photoUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool checkboxValueA = true;
    bool checkboxValueB = false;
    bool checkboxValueC = false;

    //List<address> addresLst = loadAddress() as List<address> ;
    return Container(
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
                    FutureBuilder(
                      future: imageUrl,
                      builder: (_, snap) {
                        if (snap.connectionState == ConnectionState.done &&
                            snap.hasData &&
                            snap.data != null) {
                          return GestureDetector(
                            child: Container(
                              height: 100,
                              width: 100,
                              margin: EdgeInsets.all(7.0),
                              alignment: Alignment.topCenter,
                              child: ClipOval(
                                child: Image.network(snap.data),
                              ),
                            ),
                            /* onTap: () async {
                              var _image = await ImagePicker.pickImage(
                                source: ImageSource.gallery,
                              );
                              final StorageReference ref = FirebaseStorage
                                  .instance
                                  .ref()
                                  .child(u.imageUrl);
                              final StorageUploadTask uploadTask =
                                  ref.putFile(_image);
                              await uploadTask.onComplete;
                              setState(() {
                                u.imageUrl = u.imageUrl;
                              });
                            }, */
                          );
                        } else {
                          return Center(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                    FlatButton(
                      onPressed: () =>
                          debugPrint(StackTrace.current.toString()),
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
                                child: Text(u.displayName),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(u.displayName),
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
                            onPressed: () =>
                                debugPrint(StackTrace.current.toString()),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    VerticalDivider(),
                                    Text(
                                      '16th D Cross Road',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 13.0,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    VerticalDivider(),
                                    Text(
                                      'PAI Layout',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 13.0,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    VerticalDivider(),
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
                              onPressed: () =>
                                  debugPrint(StackTrace.current.toString()),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    VerticalDivider(),
                                    Text(
                                      '16th D Cross Road',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 13.0,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    VerticalDivider(),
                                    Text(
                                      'PAI Layout',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 13.0,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    VerticalDivider(),
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
                              onPressed: () =>
                                  debugPrint(StackTrace.current.toString()),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    VerticalDivider(),
                                    Text(
                                      '16th D Cross Road',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 13.0,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    VerticalDivider(),
                                    Text(
                                      'PAI Layout',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 13.0,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    VerticalDivider(),
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
                              onPressed: () =>
                                  debugPrint(StackTrace.current.toString()),
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
                      onPressed: () =>
                          debugPrint(StackTrace.current.toString()),
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
                      onPressed: () =>
                          debugPrint(StackTrace.current.toString()),
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
                      onPressed: () =>
                          debugPrint(StackTrace.current.toString()),
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
    );
  }

  _verticalD() {
    return Container(
      margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
    );
  }
}

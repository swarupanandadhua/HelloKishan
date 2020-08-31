import 'package:FarmApp/Services/DatabaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:geocoder/geocoder.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  FirebaseUser u;
  Future<String> photoUrl;

  @override
  void initState() {
    u = Provider.of<FirebaseUser>(context, listen: false);
    assert(u != null);
    photoUrl = DatabaseService().getPhotoUrl(u.photoUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Address> addresses = List<Address>();
    addresses.insert(0, Address());
    addresses.insert(0, Address());
    addresses.insert(0, Address());
    addresses.insert(0, null);

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
                elevation: 4,
                child: Column(
                  children: <Widget>[
                    FutureBuilder(
                      future: photoUrl,
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
                                  .child(u.photoUrl);
                              final StorageUploadTask uploadTask =
                                  ref.putFile(_image);
                              await uploadTask.onComplete;
                              setState(() {
                                u.photoUrl = u.photoUrl;
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
                                child: Text(u?.email ?? 'ERROR'),
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
              margin: EdgeInsets.only(left: 12.0, top: 5.0, bottom: 5.0),
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
              height: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) {
                  return Container(
                    /* TODO 6 : Create a PLUS icon to add address */
                    child: Text('Add Address'),
                  );
                },
                itemCount: addresses.length,
              ),
            ),
            Container(
              margin: EdgeInsets.all(7.0),
              child: Card(
                elevation: 1,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.vpn_key,
                      ),
                      onPressed: () =>
                          debugPrint(StackTrace.current.toString()),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 3.0),
                    ),
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
                elevation: 1,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.history,
                      ),
                      onPressed: () =>
                          debugPrint(StackTrace.current.toString()),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 3.0),
                    ),
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
                elevation: 1,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.do_not_disturb_on,
                      ),
                      onPressed: () =>
                          debugPrint(StackTrace.current.toString()),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 3.0),
                    ),
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
}

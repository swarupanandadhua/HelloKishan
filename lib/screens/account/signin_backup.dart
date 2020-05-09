/* TODO: Merge this file with ./signin.dart */

import 'package:farmapp/screens/home/home.dart';
import 'package:farmapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key key, this.title, this.auth}) : super(key: key);

  final String title;
  final BaseAuth auth;

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
  );

  bool _validEmail = true;
  bool _validPassword = true;
  String _password;
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 150,
                      child: Image.asset(
                        'images/app_logo.jpg',
                        height: 150,
                        width: 150,
                      ),
                    ),
                    SizedBox(
                      height: 45.0,
                    ),
                    TextField(
                      style: style,
                      onChanged: (val) => (_email = val),
                      onTap: () => _clearCredentialError(),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(
                          20.0,
                          15.0,
                          20.0,
                          15.0,
                        ),
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        errorText: _validEmail ? null : 'Enter valid email',
                      ),
                    ),
                    SizedBox(height: 25.0),
                    TextField(
                      style: style,
                      onChanged: (val) => (_password = val),
                      onTap: () => _clearCredentialError(),
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(
                          20.0,
                          15.0,
                          20.0,
                          15.0,
                        ),
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        errorText:
                            _validPassword ? null : 'Enter valid password',
                      ),
                    ),
                    SizedBox(height: 35.0),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.indigo,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () => (_validateCredentials() != null)
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              )
                            : null,
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: style.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    GestureDetector(
                      onTap: () => print('TODO: Invoke FORGOT PASSWORD method'),
                      child: SizedBox(
                        height: 15.0,
                        child: Text(
                          'Forgot Password ?',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    GestureDetector(
                      onTap: () => print('TODO: Invoke REGISTER method'),
                      child: SizedBox(
                        height: 25.0,
                        child: Text(
                          'REGISTER',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _validateCredentials() async {
    setState(() {
      _validEmail = (((_email != null) ? _email.length : 0) > 5);
      _validPassword = (((_password != null) ? _password.length : 0) > 5);
    });
    if (_validEmail && _validPassword) {
      String uid;
      Auth().signIn(_email, _password).then((val) => uid = val);
      if (uid != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', _email);
        prefs.setString('uid', uid);
      }
      return Future(() => (uid != null));
    }
    return Future(() => false);
  }

  _clearCredentialError() {
    setState(() {
      _validPassword = true;
      _validEmail = true;
    });
  }
}

import 'package:farmapp/services/authentication.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({this.toggleView});
  final Function toggleView;

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String _error = '', _password, _email;

  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 60.0),
                      SizedBox(
                        height: 150,
                        child: Image.asset(
                          'images/app_logo.jpg',
                          height: 150,
                          width: 150,
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        _error,
                        style: TextStyle(color: Colors.red, fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 45.0,
                      ),
                      TextFormField(
                        style: style,
                        validator: (val) {
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = RegExp(pattern);
                          return (!regex.hasMatch(val))
                              ? 'Enter Valid Email'
                              : null;
                        },
                        onChanged: (val) => (_email = val),
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
                        ),
                      ),
                      SizedBox(height: 25.0),
                      TextFormField(
                        style: style,
                        validator: (val) =>
                            val.length < 6 ? "Enter valid Password" : null,
                        onChanged: (val) => (_password = val),
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
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              dynamic result = await AuthenticationService()
                                  .signInWithEmailPassword(_email, _password);
                              if (result == null) {
                                AlertDialog(
                                  title: Text('Dialog Title'),
                                  content: Text('This is my content'),
                                );
                                /* 

                                setState(() {
                                  error = 'Credential error';
                                }); */
                              }
                            }
                          },
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
                        onTap: () =>
                            print('TODO: Invoke FORGOT PASSWORD method'),
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
                        onTap: () {
                          widget.toggleView();
                        },
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
      ),
    );
  }
}

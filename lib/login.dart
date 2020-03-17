import 'package:farmapp/home.dart';
import 'package:farmapp/signup.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  const LoginScreen(
      {Key key,
      this.fieldKey,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted})
      : super(key: key);

  ThemeData buildTheme() {
    final ThemeData base = ThemeData();
    return base.copyWith(
      hintColor: Colors.red,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: Colors.yellow,
          fontSize: 24.0,
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  ShapeBorder shape;

  String _email;
  String _password;

  bool _autovalidate = false;
  bool _formWasEdited = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool _obscureText = true;
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 50.0,
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 7.0),
                child: Row(
                  children: <Widget>[
                    _verticalD(),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _verticalD(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                top: false,
                bottom: false,
                child: Card(
                  elevation: 5.0,
                  child: Form(
                    key: formKey,
                    autovalidate: _autovalidate,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(height: 24.0),
                          TextFormField(
                            decoration: const InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black87,
                                      style: BorderStyle.solid),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black87,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.black38,
                                ),
                                labelText: 'E-mail',
                                labelStyle: TextStyle(color: Colors.black54)),
                            keyboardType: TextInputType.emailAddress,
                            validator: _validateEmail,
                            onSaved: (val) => _email = val,
                          ),
                          const SizedBox(height: 24.0),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black87,
                                    style: BorderStyle.solid),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black87,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              icon: Icon(
                                Icons.lock,
                                color: Colors.black38,
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            validator: (val) =>
                                val.length < 8 ? 'Password too short.' : null,
                            onSaved: (val) => _password = val,
                            onChanged: _setPassword,
                          ),
                          SizedBox(
                            height: 35.0,
                          ),
                          Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  margin: EdgeInsets.only(left: 10.0),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      'FORGOT PASSWORD?',
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 13.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      _submit();
                                    },
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        color: Colors.indigo,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), //login,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }

  void _performLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      _performLogin();
    }
  }

  Widget _verticalD() {
    return Container(
      margin: EdgeInsets.only(
        left: 10.0,
        right: 0.0,
        top: 0.0,
        bottom: 0.0,
      ),
    );
  }

  String _validateEmail(String value) {
    final RegExp emailExp = RegExp(r'^[A-Za-z0-9\.\_]+@[A-Za-z0-9]+\.com$');
    if (!emailExp.hasMatch(value)) {
      return 'Enter a valid Email';
    }
    return null;
  }

  void _setPassword(String value) {
    setState(() => _password = value); // TODO: Doesnt work
  }
}

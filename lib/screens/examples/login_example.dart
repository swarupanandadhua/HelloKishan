import 'package:flutter/material.dart';
import 'package:validate/validate.dart';

class LoginScreen extends StatefulWidget {
  final String title;

  LoginScreen({
    this.title,
    key,
  }) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginData {
  String email = '', password = '';
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  LoginData _loginData = LoginData();

  String _validateEmail(String value) {
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'Please enter a valid email.';
    }
    return null;
  }

  void _submit() {
    if (_loginFormKey.currentState.validate()) {
      _loginFormKey.currentState.save();

      debugPrint('Email: ${_loginData.email}');
      debugPrint('Password: ${_loginData.password}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _loginFormKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'you@example.com',
                  labelText: 'E-mail Address',
                ),
                validator: _validateEmail,
                onSaved: (String value) {
                  _loginData.email = value;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Enter your password',
                ),
                validator: (value) => (value.length < 8)
                    ? 'Password must contain 8 characters.'
                    : null,
                onSaved: (String value) {
                  _loginData.password = value;
                },
              ),
              Container(
                width: screenSize.width,
                child: RaisedButton(
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: _submit,
                  color: Colors.blue,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

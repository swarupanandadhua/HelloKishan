import 'package:farmapp/models/constants.dart';
import 'package:farmapp/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:validate/validate.dart';

class RegisterScreen extends StatefulWidget {
  final Function toggleView;
  RegisterScreen({this.toggleView});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _error = '', _email = '', _password = '';

  final TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
  );

  Widget showLogo() {
    return SizedBox(
      height: 150,
      child: Image.asset(
        FARMAPP_LOGO,
        height: 150,
        width: 150,
      ),
    );
  }

  Widget showEmailInput() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (val) {
        try {
          Validate.isEmail(val);
        } catch (e) {
          debugPrint(e);
          return 'Enter valid Email';
        }
        return null;
      },
      style: style,
      onChanged: (val) => (_email = val),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(
          20.0,
          15.0,
          20.0,
          15.0,
        ),
        hintText: 'Enter valid Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
//        errorText: _validEmail ? null : 'Enter valid email',
      ),
    );
  }

  Widget showPasswordInput() {
    return TextFormField(
      validator: (val) => val.length < 6 ? 'Enter valid Password' : null,
      style: style,
      onChanged: (val) => (_password = val),
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(
          20.0,
          15.0,
          20.0,
          15.0,
        ),
        hintText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
//        errorText: _validPassword ? null : 'Enter valid password',
      ),
    );
  }

  Widget registerButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.indigo,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            dynamic result = await AuthenticationService()
                .registerWithEmailPass(_email, _password);
            if (result == null) {
              setState(() {
                _error = 'User already exists';
              });
            }
          }
        },
        child: Text(
          'Register',
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget goSignInScreen() {
    return GestureDetector(
      onTap: () {
        widget.toggleView();
      },
      child: SizedBox(
        height: 25.0,
        child: Text(
          'SIGN IN',
          style: TextStyle(
            color: Colors.indigo,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 60.0), // Breathing space
                  showLogo(),
                  SizedBox(height: 12.0),
                  Text(
                    _error,
                    style: TextStyle(color: Colors.red, fontSize: 20.0),
                  ),
                  SizedBox(height: 45.0), // Breathing space
                  showEmailInput(),
                  SizedBox(height: 25.0), // Breathing space
                  showPasswordInput(),
                  SizedBox(height: 35.0),
                  registerButton(),
                  SizedBox(height: 15.0),
                  goSignInScreen(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

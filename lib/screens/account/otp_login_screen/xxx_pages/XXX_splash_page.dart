import 'package:farmapp/screens/account/otp_login_screen/xxx_main/XXX_theme.dart';
import 'package:farmapp/screens/account/otp_login_screen/xxx_pages/XXX_home_page.dart';
import 'package:farmapp/screens/account/otp_login_screen/xxx_pages/XXX_login_page.dart';
import 'package:farmapp/screens/account/otp_login_screen/xxx_stores/XXX_login_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<LoginStore>(context, listen: false)
        .isAlreadyAuthenticated()
        .then((result) {
      if (result) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomePage()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColors.primaryColor,
    );
  }
}

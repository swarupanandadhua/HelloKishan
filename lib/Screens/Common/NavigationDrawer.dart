import 'package:FarmApp/Models/Assets.dart';
import 'package:FarmApp/Models/Colors.dart';
import 'package:FarmApp/Models/Constants.dart';
import 'package:FarmApp/Models/Strings.dart';
import 'package:FarmApp/Screens/Profile/OTPLoginScreen.dart';
import 'package:FarmApp/Screens/Profile/ProfileUpdateScreen.dart';
import 'package:FarmApp/Services/AuthService.dart';
import 'package:FarmApp/Services/SharedPrefData.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text(''),
                        ),
                        body: ProfileUpdateScreen(),
                      );
                    },
                  ),
                );
              },
              // TODO: Show Profile Picture as well
              child: Container(
                height: 120,
                child: DrawerHeader(
                  child: Column(
                    children: [
                      Text(
                        SharedPrefData.getName(),
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      ClipOval(
                        child: Image.network(
                          SharedPrefData.getPhotoURL(),
                          height: 50,
                          width: 50,
                          loadingBuilder: (_, c, prog) {
                            return (prog == null)
                                ? c
                                : Image.asset(
                                    ASSET_LOADING,
                                    height: 30,
                                    width: 30,
                                  );
                          },
                          errorBuilder: (_, __, ___) => Image.asset(
                            ASSET_RED_CROSS,
                            height: 30,
                            width: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(color: Color(APP_COLOR)),
                ),
              ),
            ),
            // TODO: Add leading Icons to the followgs...
            ListTile(
              title: Text(STRING_KYC),
              onTap: () => debugPrint(StackTrace.current.toString()),
            ),
            ListTile(
              title: Text(STRING_HELP),
              onTap: () => UrlLauncher.launch(HELP_MAIL_ARG),
            ),
            ListTile(
              title: Text(STRING_SETTINGS),
              onTap: () => debugPrint(StackTrace.current.toString()),
            ),
            ListTile(
              title: Text(STRING_FEEDBACK),
              onTap: () => debugPrint(StackTrace.current.toString()),
            ),
            ListTile(
              title: Text(STRING_SIGN_OUT),
              onTap: () async {
                await AuthService().signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OTPLoginScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

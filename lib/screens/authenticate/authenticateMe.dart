import 'package:flutter/material.dart';
import 'package:flutterMaps/screens/authenticate/regi_ster.dart';
import 'package:flutterMaps/screens/authenticate/sign_in.dart';

class AuthenticateMe extends StatefulWidget {
  @override
  _AuthenticateMeState createState() => _AuthenticateMeState();
}

class _AuthenticateMeState extends State<AuthenticateMe> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return UserSignIn(toggleMyView: toggleView);
    } else {
      return RegisterMe(toggleMyView: toggleView);
    }
  }
}

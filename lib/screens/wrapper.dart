import 'package:flutter/material.dart';
import 'package:flutterMaps/models/myUser.dart';
import 'package:flutterMaps/screens/authenticate/authenticateMe.dart';
import 'package:flutterMaps/screens/home/homeScreen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apnaUser = Provider.of<MyUser>(context);
    // return either home or authenticate widget
    if (apnaUser == null) {
      return AuthenticateMe();
    } else {
      return HomeScreen();
    }
  }
}

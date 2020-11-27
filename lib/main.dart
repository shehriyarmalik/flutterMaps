import 'package:flutter/material.dart';
import 'package:flutterMaps/models/myUser.dart';
import 'package:flutterMaps/screens/home/homeScreen.dart';
import 'package:flutterMaps/screens/wrapper.dart';
import 'package:flutterMaps/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
      initialData: null,
      value: AuthService().moiUser,
      child: MaterialApp(
        navigatorKey: mainNavigatorKey,
        home: Wrapper(),
        routes: {
          '/Welcome': (context) => Wrapper(),
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}

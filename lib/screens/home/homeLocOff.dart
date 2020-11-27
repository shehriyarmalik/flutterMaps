import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterMaps/screens/home/users_list.dart';
import 'package:flutterMaps/screens/locator_screens/myLocator_options.dart';
import 'package:flutterMaps/services/auth.dart';

class HomeLocOff extends StatefulWidget {
  final Function changeLocType;
  HomeLocOff({this.changeLocType});
  @override
  _HomeLocOffState createState() => _HomeLocOffState();
}

class _HomeLocOffState extends State<HomeLocOff> {
  final AuthService _authMy = AuthService();
  int locType = 0;
  String permState = '';

  void toggleLocType(int locState) {
    setState(() {
      locType = locState;
    });
    widget.changeLocType(locType);
  }

  @override
  Widget build(BuildContext context) {
    if (locType == 3) {
      setState(() {
        permState = 'LOCATION   ON';
      });
    } else
      setState(() {
        permState = 'LOCATION   OFF';
      });
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Users List'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('give Location'),
            onPressed: () {
              if (locType == 2 || locType == 1) {
                setState(() {
                  locType = 0;
                });
                widget.changeLocType(locType);
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyLocatorOptions(
                          toggleLocType: toggleLocType,
                          locType: locType,
                        )),
              );
            },
          ),
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              await _authMy.signMeOut();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          width: 30,
          height: 40,
          child: Center(
              child: Text(
            permState,
            style: TextStyle(fontSize: 30),
          )),
          color: Colors.red,
        ),
      ),
      body: UsersList(
        locType: locType,
      ),
    );
  }
}

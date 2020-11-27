import 'package:flutter/material.dart';
import 'package:flutterMaps/services/auth.dart';
import 'package:flutterMaps/shared/constants.dart';
import 'package:flutterMaps/shared/myLoading.dart';

class UserSignIn extends StatefulWidget {
  final Function toggleMyView;
  UserSignIn({this.toggleMyView});
  @override
  _UserSignInState createState() => _UserSignInState();
}

class _UserSignInState extends State<UserSignIn> {
  final AuthService _authi = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool myLoading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return myLoading
        ? MyLoader()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign in to client locator'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  onPressed: () {
                    widget.toggleMyView();
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          myTextInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          myTextInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.grey[10]),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            myLoading = true;
                          });
                          dynamic moiUsaCred = await _authi
                              .signInWithEmailAndPassword(email, password);
                          if (moiUsaCred == null) {
                            setState(() {
                              myLoading = false;
                              error =
                                  'Could not sign in with those credentials';
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

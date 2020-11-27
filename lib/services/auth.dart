import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterMaps/models/myUser.dart';
import 'package:flutterMaps/services/myDatabase.dart';

class AuthService {
  final FirebaseAuth _authy = FirebaseAuth.instance;

  // create user obj based on firebaseUser
  MyUser _userFromFireBaseUser(User meFireUser) {
    return meFireUser != null ? MyUser(theUid: meFireUser.uid) : null;
  }

  // auth change user stream
  Stream<MyUser> get moiUser {
    return _authy
        .authStateChanges()
        .map((User meraUser) => _userFromFireBaseUser(meraUser));
  }

  // register with email and password
  Future registerWithEmailAndPassword(String myEmail, String myPassword) async {
    try {
      GeoPoint userLocation = GeoPoint(0.0, 0.0);
      UserCredential myUserCredy = await _authy.createUserWithEmailAndPassword(
          email: myEmail, password: myPassword);
      User meUsy = myUserCredy.user;

      // create a new document for the user with the uid
      await MyDatabaseService(myUid: meUsy.uid)
          .setupMyUserData('new client', userLocation);
      return _userFromFireBaseUser(meUsy);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String myEmail, String myPassword) async {
    try {
      UserCredential myUserCredy = await _authy.signInWithEmailAndPassword(
          email: myEmail, password: myPassword);
      User meUsy = myUserCredy.user;
      return _userFromFireBaseUser(meUsy);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signMeOut() async {
    try {
      return await _authy.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

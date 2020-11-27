import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String theUid;
  MyUser({this.theUid});
}

class MyUserData {
  final String name;
  final String ziUid;
  final GeoPoint qurryPosition;

  MyUserData({this.name, this.qurryPosition, this.ziUid});
}

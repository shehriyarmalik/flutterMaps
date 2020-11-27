import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutterMaps/models/clienty.dart';
import 'package:flutterMaps/models/myUser.dart';

class MyDatabaseService {
  final String myUid;
  MyDatabaseService({this.myUid});
  // collection reference
  final CollectionReference myUsersCollection =
      FirebaseFirestore.instance.collection('myUsers');

  Future setupMyUserData(String name, GeoPoint myLocation) async {
    return await myUsersCollection
        .doc(myUid)
        .set({'name': name, 'current Position': myLocation});
  }

  Future updateMyUserLocationData(Position myLocation) async {
    GeoPoint meLoc = GeoPoint(myLocation.latitude, myLocation.longitude);
    return await myUsersCollection
        .doc(myUid)
        .update({'current Position': meLoc});
  }

  // Clients List from snapshot
  List<Clienty> _clientListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((docy) {
      return Clienty(
        name: docy.data()['name'] ?? '',
        curryPosition: docy.data()['current Position'] ?? null,
      );
    }).toList();
  }

  // get users stream
  Stream<List<Clienty>> get meClients {
    return myUsersCollection.snapshots().map(_clientListFromSnapshot);
  }

  MyUserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return MyUserData(
        name: snapshot.data()['name'],
        qurryPosition: snapshot.data()['current Position']);
  }

  Stream<MyUserData> get ziUserData {
    return myUsersCollection.doc(myUid).snapshots().map(_userDataFromSnapshot);
  }
}

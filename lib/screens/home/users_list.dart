import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutterMaps/models/clienty.dart';
import 'package:flutterMaps/models/myUser.dart';
import 'package:flutterMaps/screens/home/clientTileDesign.dart';
import 'package:flutterMaps/services/myDatabase.dart';
import 'package:provider/provider.dart';

class UsersList extends StatefulWidget {
  final int locType;
  UsersList({this.locType});
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Position ziPos;
  @override
  Widget build(BuildContext context) {
    final meClients = Provider.of<List<Clienty>>(context);

    if ((widget.locType == 3 || widget.locType == 2) &&
        (Provider.of<Position>(context) != null)) {
      // when it comes here, for each user, it uses the logged in users position
      // i should add in a clause that this should only happen if this is the logged in users index
      setState(() {
        ziPos = Provider.of<Position>(context);
      });

      MyUser meUid = Provider.of<MyUser>(context);

      MyDatabaseService(myUid: meUid.theUid).updateMyUserLocationData(ziPos);
    }
    return ListView.builder(
      itemCount: meClients.length,
      itemBuilder: (context, index) {
        return ClientTileDesign(
          ourClient: meClients[index],
          locType: widget.locType,
          clientIndex: index,
        );
      },
    );
  }
}

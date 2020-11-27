import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutterMaps/models/clienty.dart';
import 'package:flutterMaps/screens/locator_screens/myMap.dart';
import 'package:flutterMaps/services/myGeolocator_service.dart';

class ClientTileDesign extends StatefulWidget {
  final int locType;
  final Clienty ourClient;
  final int clientIndex;
  ClientTileDesign({this.ourClient, this.locType, this.clientIndex});

  @override
  _ClientTileDesignState createState() => _ClientTileDesignState();
}

class _ClientTileDesignState extends State<ClientTileDesign> {
  Position signedInUserPosition;
  Position ziPos;
  @override
  Widget build(BuildContext context) {
    setState(() {
      // this data ids coming from database
      ziPos = Position(
          latitude: widget.ourClient.curryPosition.latitude,
          longitude: widget.ourClient.curryPosition.longitude);
    });
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6.0, 20.0, 0),
        child: ListTile(
          title: Text(widget.ourClient.name),
          subtitle: Text('location = ${ziPos.latitude}, ${ziPos.longitude}'),
          trailing: RaisedButton(
            onPressed: () async {
              if (widget.locType < 2) {
                signedInUserPosition =
                    await MyGeolocatorService().sendLocationOnce();
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyMap(
                          locType: widget.locType,
                          clientIndex: widget.clientIndex,
                          signedInUserPosition: signedInUserPosition,
                        )),
              );
            },
            color: Colors.grey,
            child: const Text('Locate'),
          ),
        ),
      ),
    );
  }
}

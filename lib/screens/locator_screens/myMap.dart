import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutterMaps/models/clienty.dart';
import 'package:provider/provider.dart';

class MyMap extends StatefulWidget {
  final int locType;
  final int clientIndex;
  final Position signedInUserPosition;
  MyMap({this.locType, this.clientIndex, this.signedInUserPosition});
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  List<Marker> myMarker = [];
  Completer<GoogleMapController> _laController = Completer();
  Position startingPosition;
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> myRouteCoords;
  PolylineResult routeCoords;
  bool mountedOrNot = true;

  @override
  Widget build(BuildContext context) {
    // when it presses locate, the current location send location once should be
    //acessed none the less
    // if however, live location is being shared, provider should be called,
    // location should be set to that provider loc
    final allClients = Provider.of<List<Clienty>>(context);
    Clienty myClient = allClients[widget.clientIndex];

    if (widget.locType == 3) {
      setState(() {
        startingPosition = Provider.of<Position>(context);
      });
    } else {
      setState(() {
        startingPosition = widget.signedInUserPosition;
      });
    }
    Position myDest = Position(
        latitude: myClient.curryPosition.latitude,
        longitude: myClient.curryPosition.longitude);

    setState(() {
      myMarker = [];
      myMarker.add(Marker(
        markerId: MarkerId(myDest.toString()),
        position: LatLng(myDest.latitude, myDest.longitude),
      ));
    });

    getAddressPoints(startingPosition, myDest);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Mapper'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            setState(() {
              mountedOrNot = false;
            });
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      body: Center(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target:
                LatLng(startingPosition.latitude, startingPosition.longitude),
            zoom: 18.0,
          ),
          mapType: MapType.normal,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _laController.complete(controller);
          },
          markers: Set.from(myMarker),
          polylines: Set<Polyline>.of(polylines.values),
        ),
      ),
    );
  }

  Future<void> centerScreen(Position ziPosition) async {
    final GoogleMapController myController = await _laController.future;
    myController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(ziPosition.latitude, ziPosition.longitude),
        zoom: 18.0)));
  }

  _addPolyLine() {
    PolylineId id = PolylineId('poly');
    Polyline polyline =
        Polyline(polylineId: id, color: Colors.red, points: myRouteCoords);
    polylines[id] = polyline;
    setState(() {});
  }

  getAddressPoints(Position starty, Position endy) async {
    routeCoords = await polylinePoints.getRouteBetweenCoordinates(
        'insert key ',
        PointLatLng(starty.latitude, starty.longitude),
        PointLatLng(endy.latitude, endy.longitude),
        travelMode: TravelMode.driving);
    myRouteCoords = new List<LatLng>(routeCoords.points.length);
    for (int i = 0; i < routeCoords.points.length; i++) {
      myRouteCoords[i] = LatLng(
          routeCoords.points[i].latitude, routeCoords.points[i].longitude);
    }
    if (mountedOrNot) {
      _addPolyLine();
    }
  }
}

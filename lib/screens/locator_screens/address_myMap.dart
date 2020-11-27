import 'dart:async';
import 'package:address_search_field/address_search_field.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutterMaps/models/myUser.dart';
import 'package:flutterMaps/services/myDatabase.dart';
import 'package:provider/provider.dart';

class AddressMyMap extends StatefulWidget {
  final AddressPoint myAddress;
  AddressMyMap({this.myAddress});
  @override
  _AddressMyMapState createState() => _AddressMyMapState();
}

class _AddressMyMapState extends State<AddressMyMap> {
  Completer<GoogleMapController> _laController = Completer();
  List<Marker> myMarker = [];
  Position ziPoint;
  @override
  Widget build(BuildContext context) {
    MyUser meUsy = Provider.of<MyUser>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Tap on the point that \n matches your address'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: GoogleMap(
          //markers: _markers,
          initialCameraPosition: CameraPosition(
            target:
                LatLng(widget.myAddress.latitude, widget.myAddress.longitude),
            zoom: 18.0,
          ),
          mapType: MapType.normal,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _laController.complete(controller);
          },
          markers: Set.from(myMarker),
          onTap: (myPoint) {
            _handleTap(myPoint);
            MyDatabaseService(myUid: meUsy.theUid)
                .updateMyUserLocationData(ziPoint);
          },
        ),
      ),
    );
  }

  _handleTap(LatLng tappedPoint) {
    setState(() {
      myMarker = [];
      myMarker.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
      ));
      ziPoint = Position(
          latitude: tappedPoint.latitude, longitude: tappedPoint.longitude);
    });
  }
}

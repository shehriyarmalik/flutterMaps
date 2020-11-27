import 'package:custom_navigator/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutterMaps/models/clienty.dart';
import 'package:flutterMaps/screens/home/homeLocOff.dart';
import 'package:flutterMaps/services/myDatabase.dart';
import 'package:flutterMaps/services/myGeolocator_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  int locLevel = 0;
  void changeLocType(int locType) {
    setState(() {
      locLevel = locType;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (locLevel) {
      case 0:
        {
          return StreamProvider<List<Clienty>>.value(
              initialData: [],
              value: MyDatabaseService().meClients,
              child: CustomNavigator(
                navigatorKey: navigatorKey,
                home: HomeLocOff(
                  changeLocType: changeLocType,
                ),
                pageRoute: PageRoutes.materialPageRoute,
              ));
        }
        break;
      case 2:
        {
          return StreamProvider<List<Clienty>>.value(
            initialData: [],
            value: MyDatabaseService().meClients,
            child: FutureProvider<Position>(
                initialData: null,
                create: (context) => MyGeolocatorService().sendLocationOnce(),
                child: CustomNavigator(
                  navigatorKey: navigatorKey,
                  home: HomeLocOff(
                    changeLocType: changeLocType,
                  ),
                  pageRoute: PageRoutes.materialPageRoute,
                )),
          );
        }
        break;
      case 3:
        {
          return StreamProvider<List<Clienty>>.value(
            initialData: [],
            value: MyDatabaseService().meClients,
            child: StreamProvider<Position>.value(
                initialData: null,
                value: MyGeolocatorService().getCurrentLocation(),
                child: CustomNavigator(
                  navigatorKey: navigatorKey,
                  home: HomeLocOff(
                    changeLocType: changeLocType,
                  ),
                  pageRoute: PageRoutes.materialPageRoute,
                )),
          );
        }
        break;
      default:
        {
          {
            return StreamProvider<List<Clienty>>.value(
                initialData: [],
                value: MyDatabaseService().meClients,
                child: CustomNavigator(
                  navigatorKey: navigatorKey,
                  home: HomeLocOff(
                    changeLocType: changeLocType,
                  ),
                  pageRoute: PageRoutes.materialPageRoute,
                ));
          }
        }
        break;
    }
  }
}

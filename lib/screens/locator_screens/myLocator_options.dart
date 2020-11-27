import 'package:flutter/material.dart';
import 'package:flutterMaps/screens/locator_screens/address_form.dart';

class MyLocatorOptions extends StatefulWidget {
  //
  final Function toggleLocType;
  final int locType;
  MyLocatorOptions({this.toggleLocType, this.locType});
  @override
  _MyLocatorOptionsState createState() => _MyLocatorOptionsState();
}

class _MyLocatorOptionsState extends State<MyLocatorOptions> {
  String locAction = '';
  int locState;

  @override
  Widget build(BuildContext context) {
    if (widget.locType == 3) {
      setState(() {
        locAction = 'Stop Sharing Location';
      });
    } else {
      setState(() {
        locAction = 'Share live location';
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Location Options'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              minWidth: 200,
              child: RaisedButton(
                color: Colors.grey[600],
                onPressed: () {
                  setState(() {
                    if (widget.locType != 3)
                      locState = 3;
                    else
                      locState = 0;
                  });
                  widget.toggleLocType(locState);
                  Navigator.pop(context);
                },
                child: Text(locAction),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              minWidth: 200,
              child: RaisedButton(
                color: Colors.grey[600],
                onPressed: () {
                  setState(() {
                    locState = 2;
                  });
                  widget.toggleLocType(locState);
                  Navigator.pop(context);
                },
                child: Text('Send Current Location'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              minWidth: 200,
              child: RaisedButton(
                color: Colors.grey[600],
                onPressed: () {
                  setState(() {
                    locState = 1;
                  });
                  widget.toggleLocType(locState);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddressForm()),
                  );
                },
                child: Text('Set Location by Address'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

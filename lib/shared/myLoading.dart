import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Center(
        child: SpinKitDoubleBounce(
          color: Colors.grey,
          size: 50.0,
        ),
      ),
    );
  }
}

import 'package:address_search_field/address_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutterMaps/screens/locator_screens/address_myMap.dart';

class AddressBottomSheet extends StatelessWidget {
  final String myCountry;
  final String myCity;
  AddressBottomSheet({this.myCity, this.myCountry});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            SizedBox(
              child: Text(
                  'In the field below,\ntype only a few words of your address. \nChoose the closest matching address from the bar \nbelow the text field. \nClick on it and move to the next page \nThere, you will specify your location exactly'),
            ),
            AddressSearchBox(
              controller: TextEditingController(),
              country: myCountry,
              city: myCity,
              hintText: 'Write Address here',
              noResultsText: 'Address not Found',
              onDone: (BuildContext dialogContext, AddressPoint point) {
                print(point.latitude);
                print(point.longitude);
                if ((point.latitude != 0 || point.longitude != 0)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddressMyMap(
                              myAddress: point,
                            )),
                  );
                }
              },
              onCleaned: () {},
            ),
          ],
        ),
      ),
    );
  }
}

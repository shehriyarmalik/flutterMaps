import 'package:flutter/material.dart';
import 'package:flutterMaps/screens/locator_screens/addressBottomSheet.dart';
import 'package:flutterMaps/shared/constants.dart';

class AddressForm extends StatefulWidget {
  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();
  String country = '-';
  String city = '-';

  @override
  Widget build(BuildContext context) {
    void _showAddressPanel() {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return AddressBottomSheet(
              myCountry: country,
              myCity: city,
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Address form'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: myTextInputDecoration.copyWith(hintText: 'Country'),
                validator: (val) =>
                    val.length <= 1 ? 'Enter your Country' : null,
                onChanged: (val) {
                  setState(() {
                    country = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: myTextInputDecoration.copyWith(hintText: 'City'),
                validator: (val) => val.length <= 1 ? 'city' : null,
                onChanged: (val) {
                  setState(() {
                    city = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.grey[10]),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _showAddressPanel();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

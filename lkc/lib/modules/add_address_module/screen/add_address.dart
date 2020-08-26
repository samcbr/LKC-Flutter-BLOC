import 'package:flutter/material.dart';
import 'package:lkc/modules/add_address_module/bloc/address_bloc.dart';

class AddAddress extends StatefulWidget {
  String uId;
  AddAddress(this.uId);
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  AddressBloc addressBloc = AddressBloc();
  final _formKey = GlobalKey<FormState>();
  String pinCode = '';
  String houseNumber = '';
  String area = '';
  String phone = '';
  bool validatePin = false;
  bool validateHouseNum = false;
  bool validateArea = false;
  bool validatePhone = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter Pincode',
                    labelText: 'Pincode',
                  ),
                  onChanged: (value) {
                    pinCode = value;
                    validatePin = true;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Pincode cannot be empty';
                    } else
                      return null;
                  },
                  autovalidate: validatePin,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Enter House Number',
                      labelText: 'House Number'),
                  onChanged: (value) {
                    houseNumber = value;
                    validateHouseNum = true;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'House Number cannot be empty';
                    } else
                      return null;
                  },
                  autovalidate: validateHouseNum,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Enter Area/Street Name',
                      labelText: 'Street Name'),
                  onChanged: (value) {
                    area = value;
                    validateArea = true;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Street/Area cannot be empty';
                    } else
                      return null;
                  },
                  autovalidate: validateArea,
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Enter your mobile Number',
                      labelText: 'Mobile Number'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Mobile Number cannot be empty';
                    } else
                      return null;
                  },
                  onChanged: (value) {
                    phone = value;
                    validatePhone = true;
                  },
                  autovalidate: validatePhone,
                ),
                SizedBox(
                  height: 64,
                ),
                RaisedButton(
                  padding: EdgeInsets.all(16),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      String address =
                          houseNumber + ',' + area + ' , ' + pinCode;
                      print(address + phone + widget.uId);
                      await addressBloc.addDeliveryDetails(
                          address, phone, widget.uId);

                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Save Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 1.25,
                      wordSpacing: 1.25,
                    ),
                  ),
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

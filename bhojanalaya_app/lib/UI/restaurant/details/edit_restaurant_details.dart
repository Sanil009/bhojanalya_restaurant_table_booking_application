import 'package:bhojanalaya_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditRestaurantDetails extends StatefulWidget {
  @override
  _EditRestaurantDetailsState createState() => _EditRestaurantDetailsState();
}

class _EditRestaurantDetailsState extends State<EditRestaurantDetails> {
  bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Edit Details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Navigator.of(context).pushNamed('/restaurant_details');
            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 20.0, 0.0, 0.0),
                      child: Text(
                        'Edit',
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: kTextStyle,
                          // hintText: 'Name',
                          // hintStyle: ,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 10.0),
                    // TextField(
                    //   // controller: email,
                    //   decoration: InputDecoration(
                    //       labelText: 'Email',
                    //       labelStyle: kTextStyle,
                    //       focusedBorder: UnderlineInputBorder(
                    //           borderSide: BorderSide(color: Colors.green))),
                    // ),
                    // TextField(
                    //   decoration: InputDecoration(
                    //       labelText: 'Password',
                    //       labelStyle: kTextStyle,
                    //       focusedBorder: UnderlineInputBorder(
                    //           borderSide: BorderSide(color: Colors.green))),
                    //   obscureText: true,
                    // ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Contact',
                          labelStyle: kTextStyle,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: kTextStyle,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Type',
                          labelStyle: kTextStyle,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'seating_type',
                          labelStyle: kTextStyle,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Dish Speciality',
                          labelStyle: kTextStyle,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    // Checkbox(
                    //     activeColor: Colors.white,
                    //     checkColor: kRedColour,
                    //     value: checkBoxValue,
                    //     onChanged: (bool value) {
                    //       setState(() {
                    //         checkBoxValue = value;
                    //       });
                    //     }),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Avg Price',
                          labelStyle: kTextStyle,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: kTextStyle,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      onPressed: () {
                        // editUserdetails
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kGreenColour,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        padding: EdgeInsets.fromLTRB(110.0, 15.0, 110.0, 15.0),
                        child: Text(
                          'Done',
                          style: kTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    // onPressed: () {
                    //   Navigator.of(context).pop();
                    // },
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/restaurant_details');
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kRedColour,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        padding: EdgeInsets.fromLTRB(110.0, 15.0, 110.0, 15.0),
                        child: Text(
                          'Go Back',
                          style: kTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

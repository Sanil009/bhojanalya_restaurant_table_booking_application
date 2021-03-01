import 'package:flutter/material.dart';
import 'constants.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 100.0, 0.0, 0.0),
                  child: Text(
                    'Register',
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
                      labelText: 'First Name',
                      labelStyle: kTextStyle,
                      // hintText: 'EMAIL',
                      // hintStyle: ,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                SizedBox(height: 10.0),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: kTextStyle,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  obscureText: true,
                ),
                SizedBox(height: 10.0),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: kTextStyle,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: kTextStyle,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  obscureText: true,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Phone Number',
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
                SizedBox(height: 20.0),
                RaisedButton(
                  onPressed: () {},
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
                      'Sign up',
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
                    Navigator.of(context).pop();
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
    );
  }
}

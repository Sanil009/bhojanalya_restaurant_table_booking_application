import 'package:bhojanalaya_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              //Used Stack because any other widgets like colomn, containers etc
              //conatins some kind of default padding in them.
              //Hello There!
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Bhojanalya',
                          style: TextStyle(
                            fontSize: 70.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'How do you want to continue?',
                          style: kSmallTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                  color: Colors.black,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kRedColour,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    child: Text(
                      'Use as Customer',
                      style: kSmallTextStyle,
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/restaurant_login');
                  },
                  color: Colors.black,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kRedColour,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    child: Text(
                      'Use as Restaurant',
                      style: kSmallTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

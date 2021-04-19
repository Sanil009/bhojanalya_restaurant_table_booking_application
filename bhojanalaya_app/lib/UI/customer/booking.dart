import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Book Table'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                Navigator.of(context).pushNamed('/profile');
              },
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //1st Part
            Container(
              //Used Stack because any other widgets like colomn, containers etc
              //conatins some kind of default padding in them.
              //Hello There!
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 90.0, 0.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 85.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Hello',
                          style: kTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //2nd Part
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 0.0),
                child: Column(
                  children: <Widget>[
                    //Email
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: kTextStyle,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    //Password
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: kTextStyle,
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20.0),
                    //Forgot Password
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      child: GestureDetector(
                        child: InkWell(
                          child: Text(
                            'Forgot Password?',
                            style: kLoginUnderLinedText,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/reset', (route) => false);
                        },
                      ),
                    ),
                    SizedBox(height: 20.0),
                    //Login Button
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/home', (route) => false);
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kRedColour,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        padding: EdgeInsets.fromLTRB(135.0, 15.0, 135.0, 15.0),
                        child: Text(
                          'LOGIN',
                          style: kTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    //Login with google.
                    RaisedButton(
                      onPressed: () {
                        print('Login With Google');
                      },
                      color: Colors.black,
                      textColor: Colors.black,
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: ImageIcon(
                                  AssetImage('assets/images/Google.png')),
                            ),
                            SizedBox(width: 10.0),
                            Center(
                              child: Text(
                                '',
                                style: kTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
            //3rd Part
            //Register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Need an account?',
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  child: Text(
                    'Register',
                    style: kLoginUnderLinedText,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
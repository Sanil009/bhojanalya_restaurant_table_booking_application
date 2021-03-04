import 'package:bhojanalaya_app/constants.dart';
import 'UI/first_screen.dart';
import 'dart:async';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.black,
      seconds: 5,
      navigateAfterSeconds: new FirstPage(),
      title: new Text(
        'Bhojanalaya',
        textScaleFactor: 2,
      ),
      image: new Image.asset('images/app_logo.png'),
      loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.blue,
    );
  }
}

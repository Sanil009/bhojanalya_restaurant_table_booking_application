import 'package:bhojanalaya_app/UI/authentication/login.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

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
      navigateAfterSeconds: new LoginPage(),
      title: new Text(
        'Bhojanalaya',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Raleway',
        ),
        textScaleFactor: 2,
      ),

      // image: new Image.asset('images/app_logo.png'),
      loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.blue,
    );
  }
}

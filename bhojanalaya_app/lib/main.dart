import 'package:bhojanalaya_app/constants.dart';
import 'package:bhojanalaya_app/UI/customer/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'splash.dart';
import 'login.dart';
import 'home.dart';
import 'constants.dart';
import 'signup.dart';
import 'UI/customer/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginPage(),
        '/home': (BuildContext context) => new HomePage(),
        '/signup': (BuildContext context) => new Signup(),
        '/profile': (BuildContext context) => new ProfilePage(),
        '/settings': (BuildContext context) => new SettingsPage(),
      },
      title: 'Bhojanalaya',
      theme: ThemeData.dark().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        primaryColor: kRedColour,
        scaffoldBackgroundColor: Color(0xFF000000),
      ),
      home: Splash(), //title: 'Login'
    );
  }
}

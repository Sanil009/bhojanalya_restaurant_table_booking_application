import 'package:bhojanalaya_app/constants.dart';
import 'package:bhojanalaya_app/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'splash.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      title: 'Bhojanalaya',
      theme: ThemeData.dark().copyWith(
        primaryColor: kRedColour,
        scaffoldBackgroundColor: Color(0xFF000000),
      ),
      home: Splash(), //title: 'Login'
    );
  }
}

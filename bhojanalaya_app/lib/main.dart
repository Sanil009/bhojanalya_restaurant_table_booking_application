import 'package:bhojanalaya_app/constants.dart';
import 'package:bhojanalaya_app/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'splash.dart';
import 'constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

// Future main() async {
//   await DotEnv.load(fileName: ".env");
//   print(DotEnv.env);
//   runApp(MyApp());
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
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

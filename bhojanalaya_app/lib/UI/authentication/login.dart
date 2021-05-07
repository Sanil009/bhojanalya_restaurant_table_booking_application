import 'dart:convert';

import 'package:bhojanalaya_app/UI/widgets/alert_dialog.dart';
import 'package:bhojanalaya_app/UI/widgets/progress_dialog.dart';
import 'package:bhojanalaya_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../constants.dart';
import 'package:dio/dio.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Dio dio = new Dio();
  final TextEditingController emailTextEditingController =
      new TextEditingController();
  final TextEditingController passwordTextEditingController =
      new TextEditingController();
  Response response;
  Future<void> onloginbtnpressed(context) async {
    var data = {
      'email': emailTextEditingController.text,
      'password': passwordTextEditingController.text
    };
    try {
      var response = await dio.post("http://192.168.1.164:8000/api/token/",
          data: json.encode(data));
      if (response.statusCode == 200) {
        ProgressDialog progressDialog =
            buildProgressDialog(context, "Logging in...");
        await progressDialog.hide();
        print(response.statusCode);
        if (response.data['user_type'] == "C") {
          await Navigator.pushNamed(context, '/home');
        } else {
          await Navigator.pushNamed(context, '/restaurant_dashboard');
        }
      }
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return buildAlertDialog("Invalid");
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return SafeArea(
      child: Scaffold(
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
                      controller: emailTextEditingController,
                    ),
                    SizedBox(height: 10.0),
                    //Password
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: kTextStyle,
                      ),
                      controller: passwordTextEditingController,
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
                        onloginbtnpressed(context);
                        // Navigator.of(context)
                        //     .pushNamedAndRemoveUntil('/home', (route) => false);
                      },
                      color: Colors.black,
                      textColor: Colors.black,
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        padding: EdgeInsets.fromLTRB(135.0, 15.0, 135.0, 15.0),
                        child: Text(
                          'LOGIN',
                          style: kTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/first_screen', (route) => false);
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kRedColour,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        padding: EdgeInsets.fromLTRB(145.0, 15.0, 145.0, 15.0),
                        child: Text(
                          'Back',
                          style: kTextStyle,
                        ),
                      ),
                    ),
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


                    //Login with google.
                    // RaisedButton(
                    //   onPressed: () {
                    //     print('Login With Google');
                    //   },
                    //   color: Colors.black,
                    //   textColor: Colors.black,
                    //   padding: EdgeInsets.all(0.0),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: Color(0xFFFFFFFF),
                    //       borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    //     ),
                    //     padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: <Widget>[
                    //         Center(
                    //           child: ImageIcon(
                    //               AssetImage('assets/images/Google.png')),
                    //         ),
                    //         SizedBox(width: 10.0),
                    //         Center(
                    //           child: Text(
                    //             'Login With Google',
                    //             style: kTextStyle,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 15.0),
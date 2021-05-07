import 'dart:convert';

import 'package:bhojanalaya_app/UI/widgets/alert_dialog.dart';
import 'package:bhojanalaya_app/UI/widgets/progress_dialog.dart';
import 'package:bhojanalaya_app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../constants.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  Dio dio = Dio();
  TextEditingController emailcontroller = new TextEditingController();
  final baseUrl = "http://192.168.1.164:8000/api/password_reset/";
  final TextEditingController emailTextEditingController =
      new TextEditingController();
  final TextEditingController newpasswordTextEditingController =
      new TextEditingController();

  void onResetPressed(context) async {
    ProgressDialog progressDialog =
        buildProgressDialog(context, "Validating Data...");
    await progressDialog.show();
    var data = {
      'email': emailTextEditingController.text.trim(),
      'new password': newpasswordTextEditingController.text.trim(),
    };
    try {
      var response = await dio.post(
          "http://192.168.1.164:8000/api/password_reset/",
          data: json.encode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        // jsonResponse = json.decode(response.data);
        await progressDialog.hide();
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Verification Link Sent to Email!"),
                title: Text("Verification Pending"),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text('Ok'))
                ],
              );
            });
        await Future.delayed(Duration(seconds: 1), () async {
          await Navigator.pushNamed(context, '/login');
        });
      }
    } catch (e) {
      await progressDialog.hide();
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return buildAlertDialog("Invalid!");
          });
    }
    await progressDialog.hide();
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
                          'Reset',
                          style: TextStyle(
                            fontSize: 85.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Password',
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
                    //Old Password
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        labelStyle: kTextStyle,
                      ),
                    ),
                    SizedBox(height: 10.0),

                    RaisedButton(
                      onPressed: () {
                        onResetPressed(context);
                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     '/login', (route) => false);
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
                          'DONE',
                          style: kTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    //Cancel
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', (route) => false);
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kRedColour,
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        padding: EdgeInsets.fromLTRB(120.0, 15.0, 120.0, 15.0),
                        child: Text(
                          'CANCEL',
                          style: kTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

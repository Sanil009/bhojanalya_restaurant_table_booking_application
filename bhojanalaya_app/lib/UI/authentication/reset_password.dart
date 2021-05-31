import 'dart:convert';

import 'package:bhojanalaya_app/UI/widgets/alert_dialog.dart';
import 'package:bhojanalaya_app/UI/widgets/progress_dialog.dart';
import 'package:bhojanalaya_app/constants.dart';
import 'package:bhojanalaya_app/constants/urls_constants.dart';
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
  final TextEditingController tokenTextEditingController =
      new TextEditingController();
  final TextEditingController newpasswordTextEditingController =
      new TextEditingController();

  void onResetPressed(context) async {
    ProgressDialog progressDialog =
        buildProgressDialog(context, "Validating Data...");
    await progressDialog.show();
    var data = {
      'token': tokenTextEditingController.text.trim(),
      'password': newpasswordTextEditingController.text.trim(),
    };
    try {
      var response = await dio.post(api_url + "/api/password_reset/confirm/",
          data: json.encode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        // jsonResponse = json.decode(response.data);
        await progressDialog.hide();
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Password Reset Sucessfull"),
                title: Text("Sucess"),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text('Ok'))
                ],
              );
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
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 90.0, 0.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Reset Passowrd',
                          style: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                          ),
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
                      controller: tokenTextEditingController,
                      decoration: InputDecoration(
                        labelText: 'Token',
                        labelStyle: kTextStyle,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    //Old Password
                    TextField(
                      controller: newpasswordTextEditingController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: kTextStyle,
                      ),
                    ),
                    SizedBox(height: 10.0),

                    RaisedButton(
                      onPressed: () {
                        onResetPressed(context);
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

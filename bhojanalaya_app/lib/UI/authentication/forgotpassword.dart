import 'dart:convert';

import 'package:bhojanalaya_app/UI/widgets/alert_dialog.dart';
import 'package:bhojanalaya_app/UI/widgets/progress_dialog.dart';
import 'package:bhojanalaya_app/constants.dart';
import 'package:bhojanalaya_app/constants/urls_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../constants.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  Dio dio = Dio();
  TextEditingController emailcontroller = new TextEditingController();

  void forgotpassword(context) async {
    ProgressDialog progressDialog =
        buildProgressDialog(context, "Validating Data...");
    await progressDialog.show();
    var data = {
      'email': emailcontroller.text,
    };
    // var response = await dio.post(api_url + "/api/password_reset/",
    //     data: json.encode(data));
    // if (response.statusCode == 201 || response.statusCode == 200) {
    //   print("NO BUG");
    //   print(response.statusCode);
    //   print(response.data);
    // } else {
    //   print("BUG");
    //   print(response.statusCode);
    //   print(response.data);
    // }
    try {
      var response = await dio.post(api_url + "/api/password_reset/",
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
                        Navigator.pushNamed(context, '/reset');
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed("/login"),
                  child: Icon(
                    Icons.arrow_back,
                    size: 25,
                  )),
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 40.0, 0.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Forgot',
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
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: kTextStyle,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    //Old Password

                    RaisedButton(
                      onPressed: () {
                        forgotpassword(context);
                      },
                      color: Colors.black,
                      textColor: Colors.black,
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
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

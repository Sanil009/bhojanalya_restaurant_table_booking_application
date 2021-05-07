import 'dart:convert';

import 'package:bhojanalaya_app/UI/widgets/alert_dialog.dart';
import 'package:bhojanalaya_app/UI/widgets/progress_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../constants.dart';

class EditDetailsPage extends StatefulWidget {
  @override
  _EditDetailsPageState createState() => _EditDetailsPageState();
}

class _EditDetailsPageState extends State<EditDetailsPage> {
  Dio dio = Dio();
  TextEditingController emailcontroller = new TextEditingController();
  final baseUrl = "http://192.168.1.164:8000/auth/register/";
  final TextEditingController emailTextEditingController =
      new TextEditingController();
  final TextEditingController passwordTextEditingController =
      new TextEditingController();
  final TextEditingController nameTextEditingController =
      new TextEditingController();
  final TextEditingController contactTextEditingController =
      new TextEditingController();
  final TextEditingController addressTextEditingController =
      new TextEditingController();

  void onsavebtnpressed(context) async {
    ProgressDialog progressDialog =
        buildProgressDialog(context, "Validating Data...");
    await progressDialog.show();
    var data = {
      'email': emailTextEditingController.text.trim(),
      'password': passwordTextEditingController.text.trim(),
      'contact': contactTextEditingController.text.trim(),
      'name': nameTextEditingController.text.trim(),
      'address': addressTextEditingController.text.trim(),
    };
    try {
      var response = await dio.post("http://192.168.1.164:8000/auth/register/",
          data: json.encode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        // jsonResponse = json.decode(response.data);
        await progressDialog.hide();
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Details Updated"),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/edit_details');
                      },
                      child: Text('Ok'))
                ],
              );
            });
        await Future.delayed(Duration(seconds: 1), () async {
          await Navigator.pushNamed(context, '/edit_details');
        });
      }
    } catch (e) {
      await progressDialog.hide();
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return buildAlertDialog("Verification Link Sent to Email!");
          });
    }
    await progressDialog.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Edit Details'),
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 20.0, 0.0, 0.0),
                    child: Text(
                      'Edit',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: kTextStyle,
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    // controller: email,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: kTextStyle,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: kTextStyle,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    obscureText: true,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: kTextStyle,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Address',
                        labelStyle: kTextStyle,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    onPressed: () {
                      onsavebtnpressed(context);
                      // editUserdetails
                    },
                    color: Colors.black,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kGreenColour,
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      padding: EdgeInsets.fromLTRB(110.0, 15.0, 110.0, 15.0),
                      child: Text(
                        'Done',
                        style: kTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  // onPressed: () {
                  //   Navigator.of(context).pop();
                  // },
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/profile', (route) => false);
                    },
                    color: Colors.black,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kRedColour,
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      padding: EdgeInsets.fromLTRB(110.0, 15.0, 110.0, 15.0),
                      child: Text(
                        'Go Back',
                        style: kTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:bhojanalaya_app/UI/widgets/alert_dialog.dart';
import 'package:bhojanalaya_app/UI/widgets/progress_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // String _chosenValue;
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

  void onRegisterPressed(context) async {
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
      var response = await dio.post("http://192.168.1.166:8000/auth/register/",
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
            return buildAlertDialog("Error");
          });
    }
    await progressDialog.hide();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 70.0,
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
                    controller: nameTextEditingController,
                  ),
                  TextField(
                    // controller: email,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: kTextStyle,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    controller: emailTextEditingController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: kTextStyle,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    controller: passwordTextEditingController,
                    obscureText: true,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: kTextStyle,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    controller: contactTextEditingController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Address',
                        labelStyle: kTextStyle,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    controller: addressTextEditingController,
                  ),

                  SizedBox(height: 20.0),
                  RaisedButton(
                    onPressed: () {
                      onRegisterPressed(context);
                      // Navigator.of(context).pushNamed('/profile');
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
                        'Sign up',
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
                      Navigator.of(context).pop();
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
                        'Cancel',
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

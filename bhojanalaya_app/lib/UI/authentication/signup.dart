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
  String _chosenValue;
  // Dio dio = Dio();
  // TextEditingController emailcontroller = new TextEditingController();
  // final baseUrl = env['API_URL'];
  // final TextEditingController emailTextEditingController =
  //     new TextEditingController();
  // final TextEditingController passwordTextEditingController =
  //     new TextEditingController();
  // final TextEditingController usernameEditingController =
  //     new TextEditingController();

  // void onRegisterPressed(context) async {
  //   ProgressDialog progressDialog =
  //       buildProgressDialog(context, "Validating Data...");
  //   await progressDialog.show();
  //   var data = {
  //     'email': emailTextEditingController.text.trim(),
  //     'username': usernameEditingController.text.trim(),
  //     'password': passwordTextEditingController.text.trim()
  //   };
  //   try {
  //     var response = await dio.post("http://192.168.1.160/register/",
  //         data: json.encode(data));
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print(response.data);
  //       // jsonResponse = json.decode(response.data);
  //       await progressDialog.hide();
  //       await showDialog(
  //           context: context,
  //           builder: (context) {
  //             return AlertDialog(
  //               content: Text("Verification Link Sent to Email!"),
  //               title: Text("Verification Pending"),
  //               actions: [
  //                 FlatButton(
  //                     onPressed: () {
  //                       Navigator.pushNamed(context, 'login');
  //                     },
  //                     child: Text('Ok'))
  //               ],
  //             );
  //           });
  //       await Future.delayed(Duration(seconds: 1), () async {
  //         await Navigator.pushNamed(context, 'login');
  //       });
  //     }
  //   } catch (e) {
  //     await progressDialog.hide();
  //     print(e);
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return buildAlertDialog("Invalid");
  //         });
  //   }
  //   await progressDialog.hide();
  // }

  // Future<void> registerUser(String email, String password) async {
  //   try {
  //     dynamic result = dio.post(
  //       'path',
  //       data: {
  //         "email": email,
  //         "password": password,
  //       },
  //     );
  //     return result;
  //   }
  //   // on dio.DioError(Exception e) {
  //   //   return e.message;
  //   // }
  //   catch (e) {
  //     return null;
  //   }
  // }

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
                  ),
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
                  DropdownButton<String>(
                    focusColor: Colors.white,
                    value: _chosenValue,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    elevation: 5,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Male',
                      'Female',
                      'LGBTQ',
                      'Prefered not to say'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: kSmallTextStyle,
                        ),
                      );
                    }).toList(),
                    hint: Text("Gender", style: kTextStyle),
                    onChanged: (String value) {
                      setState(() {
                        _chosenValue = value;
                      });
                    },
                    onTap: () {},
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    onPressed: () {
                      // registerUser(email, password)
                      Navigator.of(context).pushNamed('/profile');
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

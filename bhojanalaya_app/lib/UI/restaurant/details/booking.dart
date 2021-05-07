import 'dart:convert';
import 'package:bhojanalaya_app/UI/widgets/alert_dialog.dart';
import 'package:bhojanalaya_app/UI/widgets/progress_dialog.dart';
import 'package:bhojanalaya_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:bhojanalaya_app/constants.dart';
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  Dio dio = new Dio();
  final baseUrl = "http://192.168.1.164:8000/bookings/";
  final TextEditingController dateTextEditingController =
      new TextEditingController();
  final TextEditingController timeTextEditingController =
      new TextEditingController();
  Response response;
  onbookingbtnpressed(context) async {
    ProgressDialog progressDialog =
        buildProgressDialog(context, "Validating Data...");
    await progressDialog.show();
    var data = {
      'date': dateTextEditingController.text,
      'time': timeTextEditingController.text
    };
    try {
      var response = await dio.post("http://192.168.1.164:8000/bookings/",
          data: json.encode(data));
      if (response.statusCode == 200) {
        await progressDialog.hide();
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(content: Text("Booking Recorded"));
            });
        print(response.statusCode);
        await Navigator.pushNamed(context, '/restaurant_details');
      }
    } catch (e) {
      await progressDialog.hide();
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return buildAlertDialog("Failed");
          });
    }
    await progressDialog.hide();
  }

// title: Text("Done")
  DateTime _dateTime;
  TimeOfDay _time;

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
                          'Book',
                          style: TextStyle(
                            fontSize: 85.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Restaurant',
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
                    Text(
                      _dateTime == null
                          ? "Nothing has been picked yet"
                          : _dateTime.toString(),
                      style: kTextStyle,
                    ),
                    RaisedButton(
                      color: Colors.black,
                      textColor: Colors.black,
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        padding: EdgeInsets.fromLTRB(100.0, 15.0, 100.0, 15.0),
                        child: Text(
                          "Select Date",
                          textAlign: TextAlign.center,
                          style: kTextStyle,
                        ),
                      ),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2222))
                            .then((date) {
                          setState(() {
                            _dateTime = date;
                          });
                        });
                      },
                    ),

                    SizedBox(height: 30.0),

                    Text(
                      _time == null
                          ? "Nothing has been picked yet"
                          : _time.toString(),
                    ),

                    RaisedButton(
                      color: Colors.black,
                      textColor: Colors.black,
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        padding: EdgeInsets.fromLTRB(100.0, 15.0, 100.0, 15.0),
                        child: Text(
                          "Select Time",
                          textAlign: TextAlign.center,
                          style: kTextStyle,
                        ),
                      ),
                      onPressed: () async {
                        TimeOfDay time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (BuildContext context, Widget child) {
                            return Theme(
                                data: ThemeData(
                                  primaryColor: kRedColour,
                                  backgroundColor: Color(0xFF000000),
                                ),
                                child: child);
                            // MediaQuery(
                            //   data: MediaQuery.of(context)
                            //       .copyWith(alwaysUse24HourFormat: true),
                            //   child: child,
                            // );
                          },
                        );
                        if (time != null)
                          setState(() {
                            _time = time;
                          });
                      },
                    ),
                    SizedBox(height: 50.0),

                    //Book Button
                    RaisedButton(
                      onPressed: () {
                        onbookingbtnpressed(context);

                        // Navigator.of(context)
                        //     .pushNamedAndRemoveUntil('/home', (route) => false);
                      },
                      color: Colors.black,
                      textColor: Colors.black,
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF00FF9D),
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                        padding: EdgeInsets.fromLTRB(135.0, 15.0, 135.0, 15.0),
                        child: Text(
                          'Book',
                          style: kTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/restaurant_details', (route) => false);
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
          ],
        ),
      ),
    );
  }
}

import 'package:bhojanalaya_app/UI/restaurant/restaurant_profile.dart';
import 'package:bhojanalaya_app/UI/restaurant/view_bookings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../../constants.dart';
import '../../splash.dart';

class RestaurantDashboard extends StatefulWidget {
  @override
  _RestaurantDashboardState createState() => _RestaurantDashboardState();
}

class _RestaurantDashboardState extends State<RestaurantDashboard> {
  LocalStorage storage = LocalStorage('storage-key');
  @override
  Widget build(BuildContext context) {
//
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'Dashboard',
              style: kTextStyle,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.person, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pushNamed('/restaurant_profile');
                },
              )
            ],
          ),
          body: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 15.0),
              child: Column(
                children: <Widget>[
                  //My Restaurant.
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new RestaurantProfile()));
                    },
                    color: Colors.black,
                    textColor: Colors.black,
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      padding: EdgeInsets.fromLTRB(92.0, 15.0, 92.0, 15.0),
                      child: Text(
                        'My Restaurant',
                        style: kTextStyle,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0),

                  //View Bookings Button
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new ViewBookings()));
                    },
                    color: Colors.black,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kRedColour,
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      padding: EdgeInsets.fromLTRB(92.0, 15.0, 92.0, 15.0),
                      child: Text(
                        'View Bookings',
                        style: kTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),

                  //Menu Button
                  // RaisedButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pushNamed('/restaurant_menu');
                  //   },
                  //   color: Colors.black,
                  //   textColor: Colors.black,
                  //   padding: EdgeInsets.all(0.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  //     ),
                  //     padding: EdgeInsets.fromLTRB(140.0, 15.0, 140.0, 15.0),
                  //     child: Text(
                  //       'Menu',
                  //       style: kTextStyle,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 20.0),

                  RaisedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Logout"),
                            content: Text("Are you sure you want to logout ?"),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    storage.deleteItem("user_id");
                                    storage.deleteItem("token");
                                    storage.deleteItem("refresh");
                                    print(storage.getItem("user_id"));
                                    print(storage.getItem("token"));
                                    print(storage.getItem("refresh"));
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new Splash()));
                                  },
                                  child: Text("Yes")),
                              ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("No")),
                            ],
                          );
                        },
                      );
                    },
                    color: Colors.black,
                    textColor: Colors.black,
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      padding: EdgeInsets.fromLTRB(129.0, 15.0, 129.0, 15.0),
                      child: Text(
                        'Logout',
                        style: kTextStyle,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class RestaurantDashboard extends StatefulWidget {
  @override
  _RestaurantDashboardState createState() => _RestaurantDashboardState();
}

class _RestaurantDashboardState extends State<RestaurantDashboard> {
  @override
  Widget build(BuildContext context) {
//
    return SafeArea(
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
                //View Bookings Button
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('', (route) => false);
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
                //My Restaurant.
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/restaurant_details');
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

                //Menu Button
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/menu');
                  },
                  color: Colors.black,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kRedColour,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    padding: EdgeInsets.fromLTRB(140.0, 15.0, 140.0, 15.0),
                    child: Text(
                      'Menu',
                      style: kTextStyle,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),

                //Help Centre.
                RaisedButton(
                  onPressed: () {},
                  color: Colors.black,
                  textColor: Colors.black,
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    padding: EdgeInsets.fromLTRB(101.0, 15.0, 101.0, 15.0),
                    child: Text(
                      'Help Centre',
                      style: kTextStyle,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),

                //Menu Button
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/restaurant_settings', (route) => false);
                  },
                  color: Colors.black,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kRedColour,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    padding: EdgeInsets.fromLTRB(129.0, 15.0, 129.0, 15.0),
                    child: Text(
                      'Settings',
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
    );
    // drawer: Drawer(
    //   child: ListView(
    //     // Removing padding from the ListView.
    //     padding: EdgeInsets.zero,
    //     children: <Widget>[
    //       DrawerHeader(
    //         child: Text(
    //           'Explore',
    //           style: kBigTextStyle,
    //         ),
    //         decoration: BoxDecoration(
    //           color: kRedColour,
    //         ),
    //       ),
    //       ListTile(
    //         title: Text('View Bookings', style: kSmallTextStyle),
    //         onTap: () {
    //           // close the drawer
    //           Navigator.pop(context);
    //         },
    //       ),
    //       ListTile(
    //         title: Text('My Restaurant', style: kSmallTextStyle),
    //         onTap: () {
    //           // close the drawer
    //           Navigator.pop(context);
    //         },
    //       ),
    //       ListTile(
    //         title: Text('Menu', style: kSmallTextStyle),
    //         onTap: () {
    //           // close the drawer
    //           Navigator.of(context).pushNamed('/menu');
    //         },
    //       ),
    //       ListTile(
    //         title: Text('Help Centre', style: kSmallTextStyle),
    //         onTap: () {
    //           // close the drawer
    //           Navigator.pop(context);
    //         },
    //       ),
    //       ListTile(
    //         title: Text('Settings', style: kSmallTextStyle),
    //         onTap: () {
    //           // close the drawer
    //           Navigator.of(context).pushNamed('/settings');
    //         },
    //       ),
    //     ],
    //   ),
    // ),
  }
}

import 'dart:convert';
import 'package:bhojanalaya_app/UI/customer/my_bookings.dart';
import 'package:bhojanalaya_app/UI/customer/profile.dart';
import 'package:bhojanalaya_app/UI/customer/restaurant_details.dart';
import 'package:bhojanalaya_app/UI/customer/view_restaurants.dart';
import 'package:bhojanalaya_app/constants/urls_constants.dart';
import 'package:bhojanalaya_app/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import '../../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocalStorage storage = LocalStorage("storage-key");
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  final baseUrl = api_url + "/auth/restaurant/";
  Response response;
  Future<List> fetchCruds() async {
    var response = await http.get(baseUrl);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    fetchCruds();
    super.initState();
  }

  Future<void> loadDashboard() async {
    fetchCruds();
    return;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; //
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'Bhojanalaya',
              style: kTextStyle,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.person, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pushNamed('/profile');
                },
              )
            ],
          ),
          drawer: Drawer(
            child: ListView(
              // Removing padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text(
                    'Explore',
                    style: kBigTextStyle,
                  ),
                  decoration: BoxDecoration(
                    color: kRedColour,
                  ),
                ),
                ListTile(
                  title: Text('My Bookings', style: kSmallTextStyle),
                  leading: Icon(Icons.calendar_today_rounded),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => new MyBookings()));
                    // close the drawer
                    // Navigator.of(context).pushNamed('/booking_list');
                  },
                ),
                ListTile(
                  title: Text('Settings', style: kSmallTextStyle),
                  leading: Icon(Icons.app_settings_alt_outlined),
                  onTap: () {
                    // close the drawer
                    Navigator.of(context).pushNamed('/settings');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout', style: kSmallTextStyle),
                  onTap: () async {
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
                                  Navigator.of(context).push(MaterialPageRoute(
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
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Container(
                  // height: MediaQuery.of(context).size.height * 0.85,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.extent(
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(5),
                    crossAxisSpacing: 5,
                    // mainAxisSpacing: 7,
                    maxCrossAxisExtent: 200.0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new ViewRestaurants())),
                        child: Container(
                          color: Colors.white,
                          margin: const EdgeInsets.all(4.0),
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.restaurant,
                                    size: 90,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "View Restaurants",
                                    style: kSmallTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new MyBookings())),
                        child: Container(
                          color: Colors.white,
                          margin: const EdgeInsets.all(4.0),
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.note,
                                    size: 90,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "My Bookings",
                                    style: kSmallTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 10, top: 2.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text(
                          "Popular Restaurants",
                          style: kTextStyle,
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new ViewRestaurants()));
                            },
                            icon: Icon(Icons.arrow_forward))
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder<List>(
                      future: fetchCruds(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data.isEmpty) {
                          return CircularProgressIndicator();
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new RestaurantDetails(
                                            list: snapshot.data,
                                            index: i,
                                          )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 300,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Restaurant: ${snapshot.data[i]["name"]}",
                                      style: kSmallTextStyle,
                                    ),
                                    decoration: BoxDecoration(
                                        color: kRedColour,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

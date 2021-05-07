import 'dart:convert';

// import 'package:bhojanalaya_app/UI/restaurant/restaurant_list.dart';
import 'package:bhojanalaya_app/UI/customer/restaurant_details.dart';
import 'package:bhojanalaya_app/UI/restaurant/restaurant_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map> myProducts =
      List.generate(1000, (index) => {"id": index, "name": "Product $index"})
          .toList();

  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  final baseUrl = "http://192.168.1.164:8000/auth/restaurant/";
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Bhojanalya',
            style: kTextStyle,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            ),
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
                  // close the drawer
                  Navigator.of(context).pushNamed('/booking_list');
                },
              ),
              // ListTile(
              //   title: Text('Saved', style: kSmallTextStyle),
              //   leading: Icon(Icons.add_box),
              //   onTap: () {
              //     // close the drawer
              //     Navigator.pop(context);
              //   },
              // ),
              // ListTile(
              //   title: Text('Help Centre', style: kSmallTextStyle),
              //   onTap: () {
              //     // close the drawer
              //     Navigator.pop(context);
              //   },
              // ),
              ListTile(
                title: Text('Settings', style: kSmallTextStyle),
                leading: Icon(Icons.app_settings_alt_outlined),
                onTap: () {
                  // close the drawer
                  Navigator.of(context).pushNamed('/settings');
                },
              ),
              // ListTile(
              //   title: Text('Menu', style: kSmallTextStyle),
              //   onTap: () {
              //     // close the drawer
              //     Navigator.of(context).pushNamed('/menu');
              //   },
              // ),
            ],
          ),
        ),
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Popular Restaurants",
                    style: kTextStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              categoriesScroller,

              FutureBuilder<List>(
                  future: fetchCruds(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data.isEmpty) {
                      return CircularProgressIndicator();
                    } else {
                      return Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
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
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Restaurant: ${snapshot.data[i]["name"]}",
                                  style: kSmallTextStyle,
                                ),
                                decoration: BoxDecoration(
                                    color: kRedColour,
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }),

              // Expanded(
              //   child: ListView.builder(
              //     controller: controller,
              //     itemCount: itemsData.length,
              //     physics: BouncingScrollPhysics(),
              //     itemBuilder: (context, index) {
              //       double scale = 1.0;
              //       if (topContainer > 0.5) {
              //         scale = index + 0.5 - topContainer;
              //         if (scale < 0) {
              //           scale = 0;
              //         } else if (scale > 1) {
              //           scale = 1;
              //         }
              //       }
              //       return Opacity(
              //         opacity: scale,
              //         child: Transform(
              //           transform: Matrix4.identity()..scale(scale, scale),
              //           alignment: Alignment.bottomCenter,
              //           child: Align(
              //               heightFactor: 0.7,
              //               alignment: Alignment.topCenter,
              //               child: itemsData[index]),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              //Top horizontal scroll view.
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(
                    color: Colors.orange.shade400,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Pizza",
                        style: kTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "0 Items",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Momo",
                          style: kTextStyle,
                          //  TextStyle(
                          //       fontSize: 25,
                          //       color: Colors.white,
                          //       fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "1 Items",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent.shade400,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Super\nSaving",
                        style: kTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "0 Items",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for appbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the appbar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone seached for something
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.restaurant),
        title: Text("Restaurant"),
      ),
    );
  }
}

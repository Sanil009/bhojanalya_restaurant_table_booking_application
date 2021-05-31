import 'dart:convert';
import 'dart:io';
import 'package:bhojanalaya_app/UI/customer/give_reviews.dart';
import 'package:http/http.dart' as http;
import 'package:bhojanalaya_app/constants/urls_constants.dart';
import 'package:flutter/material.dart';
import 'package:bhojanalaya_app/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:localstorage/localstorage.dart';

class RestaurantDetails extends StatefulWidget {
  List list;
  int index;
  RestaurantDetails({this.list, this.index});
  @override
  _RestaurantDetailsState createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  final List<String> imglist = [
    "assets/images/restaurant.jpg",
    "assets/images/burger.png",
  ];
  DateTime date = DateTime.now();
  TimeOfDay time;
  TimeOfDay timepicked;

  Future<Null> selectdate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1940),
        lastDate: DateTime(2030));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        print(
            "${date.year.toString()}-${date.month.toString()}-${date.day.toString()}");
      });
    }
  }

  Future<Null> selecttime(BuildContext context) async {
    timepicked = await showTimePicker(context: context, initialTime: time);
    if (timepicked != null) {
      setState(() {
        time = timepicked;
        print("${time.hour}-${time.minute}");
      });
    }
  }

  Future<List> fetchreviews() async {
    LocalStorage storage = LocalStorage('storage-key');
    var token = storage.getItem("token");
    // var url = Uri.parse(api_url + "/reviews/reviewslist/");
    var url = Uri.parse(api_url +
        "/reviews/reviewslist/?restaurant=${widget.list[widget.index]["user"]}");
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      print(jsonDecode(response.body));
      throw Exception("Error");
    }
  }

  Future<void> postdata() async {
    LocalStorage storage = LocalStorage('storage-key');
    var token = storage.getItem("token");
    var data = {
      "customer": storage.getItem("user_id"),
      "restaurant": widget.list[widget.index]["user"],
      "booked_date":
          "${date.year.toString()}-${date.month.toString()}-${date.day.toString()}",
      "booked_time": "${time.hour}-${time.minute}",
    };
    print(data);
    print(token);

    var url = Uri.parse(api_url + "/bookings/bookings/");
    var response = await http.post(url, body: json.encode(data), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return new AlertDialog(
              title: Text("Confirmation Pending"),
              actions: [
                FlatButton(
                    color: Colors.green,
                    onPressed: () async {
                      Navigator.of(context).pushNamed("/home");
                    },
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            );
          });
      print(response.statusCode);
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return new AlertDialog(
              title: Text("Request Error"),
              content: Text("Sign In Again"),
              actions: [
                FlatButton(
                    color: Colors.green,
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            );
          });
      print(response.body);
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchreviews();
    time = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          (widget.list[widget.index]['name']),
          style: kTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                height: 230,
                width: width,
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                  ),
                  items: imglist
                      .map((item) => Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(item),
                              fit: BoxFit.fill,
                            )),
                          ))
                      .toList(),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: size.width,
                decoration: BoxDecoration(
                  color: Color(0xFF2C2C2C),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: kRedColour,
                        ),
                        SizedBox(width: 10),
                        Text((widget.list[widget.index]['address'])),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.list[widget.index]['name'],
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new GiveReviews(
                                          index: widget.list[widget.index]
                                              ['user'],
                                        )));
                              },
                              child: Column(
                                children: [Icon(Icons.add), Text("Reviews")],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    widget.list[widget.index]['type'] == ""
                        ? Text(
                            "Type: " +
                                " " +
                                "Not Mentioned", // widget.list[widget.index][""],
                            style: TextStyle(
                              height: 1.5,
                            ),
                          )
                        : Text(
                            "Type: " +
                                (widget.list[widget.index]
                                    ['type']), // widget.list[widget.index][""],
                            style: TextStyle(
                              height: 1.5,
                            ),
                          ),
                    SizedBox(height: 20.0),
                    widget.list[widget.index]['dish_speciality'] == ""
                        ? Text(
                            "Dish Speciality: " +
                                " " +
                                "Not Mentioned", // widget.list[widget.index][""],
                            style: TextStyle(
                              height: 1.5,
                            ),
                          )
                        : Text(
                            "Dish Speciality: " +
                                (widget.list[widget.index][
                                    'dish_speciality']), // widget.list[widget.index][""],
                            style: TextStyle(
                              height: 1.5,
                            ),
                          ),
                    SizedBox(height: 20.0),
                    widget.list[widget.index]['description'] == ""
                        ? Text(
                            "Description: " +
                                " " +
                                "No description", // widget.list[widget.index][""],
                            style: TextStyle(
                              height: 1.5,
                            ),
                          )
                        : Text(
                            "Description: " +
                                (widget.list[widget.index][
                                    'description']), // widget.list[widget.index][""],
                            style: TextStyle(
                              height: 1.5,
                            ),
                          ),
                    SizedBox(height: 20.0),
                    widget.list[widget.index]['parking'] == true
                        ? Row(
                            children: [
                              Text("Parking:   "),
                              Icon(
                                Icons.done,
                                color: Colors.green,
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Text("Parking:   "),
                              Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                            ],
                          ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
              Container(
                height: 210,
                width: width,
                color: Color(0xFF2C2C2C),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: width,
                      child: Text(
                        "Place a Booking",
                        textAlign: TextAlign.center,
                        style: kTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: width,
                        child: Row(
                          children: [
                            Text(
                              "Pick Date:   ",
                              style: kSmallTextStyle,
                            ),
                            GestureDetector(
                                onTap: () {
                                  selectdate(context);
                                  print("test");
                                },
                                child: Icon(Icons.date_range))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: width,
                        child: Row(
                          children: [
                            Text(
                              "Pick Time:   ",
                              style: kSmallTextStyle,
                            ),
                            GestureDetector(
                                onTap: () {
                                  selecttime(context);
                                },
                                child: Icon(Icons.timer_rounded))
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: () => postdata(),
                        child: Text("Request Booking"))
                  ],
                ),
              ),
              Container(
                width: width,
                color: Color(0xFF2C2C2C),
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: width,
                      child: Text(
                        "Restaurant Reviews",
                        textAlign: TextAlign.center,
                        style: kTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FutureBuilder<List>(
                      future: fetchreviews(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text("Reviewer:  " +
                                                snapshot.data[index]["customer"]
                                                    ["name"]),
                                            Text(
                                              "Comment: " +
                                                  snapshot.data[index]
                                                      ["comments"],
                                              // textAlign: TextAlign.center,
                                            ),
                                            // Text(),
                                            Text(
                                              "Ratings: " +
                                                  snapshot.data[index]["rating"]
                                                      .toString(),
                                            ),
                                            // Row(
                                            //   children: [
                                            //     Text(snapshot.data[index]
                                            //             ["rating"]
                                            //         .toString()),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PricerCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double ignoreHeight = 20;
    path.lineTo(0, size.height - ignoreHeight);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - ignoreHeight);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

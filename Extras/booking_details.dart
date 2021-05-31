import 'dart:convert';

import 'package:bhojanalaya_app/UI/customer/generatepdf.dart';
import 'package:bhojanalaya_app/constants/urls_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookingDetails extends StatefulWidget {
  List list;
  int index;
  BookingDetails({this.index, this.list});
  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  Map<String, dynamic> restaurant;
  Map<String, dynamic> customer;
  List res;
  List cus;
  Future getrestaurant() async {
    final baseUrl =
        api_url + "/auth/restaurant/${widget.list[widget.index]["restaurant"]}";
    var response = await http.get(baseUrl);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print(jsonDecode(response.body));
      restaurant = jsonDecode(response.body);
      print(restaurant);
      return jsonDecode(response.body);
    } else {
      throw Exception("Error");
    }
  }

  Future getcustomer() async {
    final baseUrl =
        api_url + "/auth/customer/${widget.list[widget.index]["customer"]}";
    var response = await http.get(baseUrl);
    if (response.statusCode == 200 || response.statusCode == 201) {
      customer = jsonDecode(response.body);
      print(customer);
      return jsonDecode(response.body);
    } else {
      print(jsonDecode(response.body));
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    getcustomer();
    getrestaurant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Details"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => new GeneratePDF(
                            list: widget.list,
                            index: widget.index,
                            c: customer,
                            r: restaurant,
                          )));
                },
                child: Icon(Icons.picture_as_pdf)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "User Information",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            FutureBuilder(
              future: getcustomer(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: 200,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Name:  "),
                              Text("Email:  "),
                              Text("Contact:  "),
                              Text("Address:  ")
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasData || snapshot.data != null) {
                  return Container(
                    height: 200,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Name:  " + snapshot.data["name"]),
                              Text("Email:  " + snapshot.data["email"]),
                              Text("Contact:  " + snapshot.data["contact"]),
                              Text("Address:  " + snapshot.data["address"]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Text(
              "Restaurant Details",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            FutureBuilder(
              future: getrestaurant(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: 200,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Name:  "),
                              Text("Email:  "),
                              Text("Contact:  "),
                              Text("Address:  ")
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasData || snapshot.data != null) {
                  return Container(
                    height: 200,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Name:  " + snapshot.data["name"]),
                              Text("Email:  " + snapshot.data["email"]),
                              Text("Contact:  " + snapshot.data["contact"]),
                              Text("Address:  " + snapshot.data["address"]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Text(
              "Booking Details",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 200,
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Booking Status:  " +
                            widget.list[widget.index]["is_accepted"]),
                        Text("Booking Date:  " +
                            widget.list[widget.index]["booked_date"]),
                        Text("Booking Time:  " +
                            widget.list[widget.index]["booked_time"]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

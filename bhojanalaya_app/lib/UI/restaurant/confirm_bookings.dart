import 'dart:convert';
import 'dart:io';
import 'package:bhojanalaya_app/UI/restaurant/restaurant_dashboard.dart';
import 'package:bhojanalaya_app/constants.dart';
import 'package:bhojanalaya_app/constants/urls_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class ConfirmBookings extends StatefulWidget {
  List list;
  int index;
  ConfirmBookings({this.index, this.list});
  @override
  _ConfirmBookingsState createState() => _ConfirmBookingsState();
}

class _ConfirmBookingsState extends State<ConfirmBookings> {
  String value;
  List listItem = ["Booked", "Cancel"];
  LocalStorage storage = LocalStorage("storage-key");
  Future getrestaurant() async {
    final baseUrl =
        api_url + "/auth/restaurant/${widget.list[widget.index]["restaurant"]}";
    var response = await http.get(baseUrl);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      print(jsonDecode(response.body));
      throw Exception("Error");
    }
  }

  Future patchrequest() async {
    var token = storage.getItem("token");
    var data = {
      "id": "${widget.list[widget.index]["restaurant"]}",
      "booked_date": "${widget.list[widget.index]["booked_date"]}",
      "booked_time": "${widget.list[widget.index]["booked_time"]}",
      "customer": "${widget.list[widget.index]["customer"]}",
      "restaurant": "${widget.list[widget.index]["restaurant"]}",
      "is_accepted": "${value == "Booked" ? "true" : "false"}"
    };
    print(data);
    final baseUrl =
        api_url + "/bookings/bookings/${widget.list[widget.index]["id"]}/";
    var response = await http.put(baseUrl, body: jsonEncode(data), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => new RestaurantDashboard()));
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
      print(jsonDecode(response.body));
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
        title: Text(
          "Booking Details",
          style: kTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Customer Information",
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
            Text(
              "Change Status",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            DropdownButton(
              hint: Text("Change Status"),
              // dropdownColor: Colors.amber,
              value: value,
              items: listItem.map((valueitem) {
                return DropdownMenuItem(
                    value: valueitem, child: Text(valueitem));
              }).toList(),
              onChanged: (newvalue) {
                setState(() {
                  value = newvalue;
                  print(value);
                });
              },
            ),
            ElevatedButton(
                onPressed: () {
                  value == null ? null : patchrequest();
                },
                child: Text("Confirm"))
          ],
        ),
      ),
    );
  }
}

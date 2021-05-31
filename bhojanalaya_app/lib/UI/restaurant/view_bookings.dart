import 'dart:convert';
import 'package:bhojanalaya_app/UI/restaurant/confirm_bookings.dart';
import 'package:bhojanalaya_app/constants.dart';
import 'package:bhojanalaya_app/constants/urls_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'dart:io';

class ViewBookings extends StatefulWidget {
  @override
  _ViewBookingsState createState() => _ViewBookingsState();
}

class _ViewBookingsState extends State<ViewBookings> {
  Future<List> fetchbookings() async {
    LocalStorage storage = LocalStorage('storage-key');
    var token = storage.getItem("token");
    // var id = storage.getItem("user_id");
    // var url = Uri.parse(api_url + "/bookings/bookingslist/?restaurant=$id");
    var response = await http.get(api_url + "/bookings/bookings/", headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    // var id = storage.getItem("user_id");
    // var response = await http
    //     .get(api_url + "/bookings/bookingslist/?restaurant=$id/", headers: {
    //   HttpHeaders.contentTypeHeader: "application/json",
    //   HttpHeaders.authorizationHeader: "Bearer $token"
    // });

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      print(response.statusCode);
      return jsonDecode(response.body);
    } else {
      print(response.body);
      print(response.statusCode);
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    fetchbookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bookings",
          style: kTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List>(
              future: fetchbookings(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData || snapshot.data != null) {
                  return Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new ConfirmBookings(
                                            list: snapshot.data,
                                            index: index,
                                          )));
                                },
                                child: Card(
                                  color: Colors.grey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Booking ID:  " +
                                              snapshot.data[index]["id"]
                                                  .toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      snapshot.data[index]["is_accepted"] ==
                                              "true"
                                          ? Card(
                                              color: Colors.green,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text("Booked")),
                                            )
                                          : Card(
                                              color: Colors.red,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text("Pending")),
                                            )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

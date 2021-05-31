import 'dart:convert';
import 'dart:io';

import 'package:bhojanalaya_app/constants.dart';
import 'package:bhojanalaya_app/constants/urls_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final LocalStorage storage = new LocalStorage('storage-key');
  Future<void> fetchprofile() async {
    var id = storage.getItem("user_id");
    var response = await http.get(api_url + "/auth/customer/$id/");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception("Error");
    }
  }

  Future<List> fetchbookings() async {
    LocalStorage storage = LocalStorage('storage-key');
    var token = storage.getItem("token");
    var response = await http.get(api_url + "/bookings/bookings/", headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
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
    fetchprofile();
    fetchbookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home', (route) => false);
          },
        ),
        elevation: 0,
        title: Text('Profile', style: kTextStyle),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/edit_details', (route) => false);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: fetchprofile(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      width: double.infinity,
                      height: 100,
                      child: Container(
                        alignment: Alignment(0.0, 2),
                        child: CircleAvatar(
                          backgroundColor: Colors.amberAccent,
                          backgroundImage: snapshot.data["profile_pic"] == null
                              ? AssetImage("assets/images/ProfileIcon.jpg")
                              : NetworkImage(snapshot.data["profile_pic"]),
                          minRadius: 50.0,
                          maxRadius: 60.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      snapshot.data["name"],
                      style: TextStyle(
                        fontFamily: 'Galada',
                        fontSize: 25.0,
                        color: Colors.yellowAccent,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Address:" + " " + snapshot.data["address"],
                      style: TextStyle(
                          fontSize: 15.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Contact:" + " " + snapshot.data["contact"],
                      style: TextStyle(
                          fontSize: 15.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 15.0,
                      width: 300.0,
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Bookings",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  FutureBuilder<List>(
                                    future: fetchbookings(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(
                                          (snapshot.data.length).toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w300),
                                        );
                                      } else {
                                        return Text(
                                          "0",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w300),
                                        );
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                            // Expanded(
                            //   child: Column(
                            //     children: [
                            //       Text(
                            //         "Reviews",
                            //         style: TextStyle(
                            //             color: Colors.blueAccent,
                            //             fontSize: 22.0,
                            //             fontWeight: FontWeight.w600),
                            //       ),
                            //       SizedBox(
                            //         height: 7,
                            //       ),
                            //       Text(
                            //         "10",
                            //         style: TextStyle(
                            //             color: Colors.white,
                            //             fontSize: 22.0,
                            //             fontWeight: FontWeight.w300),
                            //       )
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

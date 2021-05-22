import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bhojanalaya_app/constants.dart';

class RestaurantBookingList extends StatefulWidget {
  RestaurantBookingList({Key key}) : super(key: key);

  @override
  _RestaurantBookingListState createState() => _RestaurantBookingListState();
}

class _RestaurantBookingListState extends State<RestaurantBookingList> {
  // final baseUrl = env["http://192.168.1.164:8000/bookings"];
  // Response response;
  // Future<List> fetchCruds() async {
  //   var response = await http.get($baseUrl);
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception("Error");
  //   }
  // }

  // @override
  // void initState() {
  //   fetchCruds();
  //   super.initState();
  // }

  // Future<void> loadDashboard() async {
  //   fetchCruds();
  //   return;
  // }

  loadDashboard() {}

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.green,
      backgroundColor: Colors.white,
      onRefresh: () => loadDashboard(), //
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/restaurant_dashboard', (route) => false);
            },
          ),
          automaticallyImplyLeading: true,
          backgroundColor: kRedColour,
          title: Text(
            "Your Bookings",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView(children: [
                Container(
                  height: 220,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      color: Colors.grey,
                      elevation: 6,
                      child: ListTile(
                        title: new Text(
                          'Sanil Shrestha',
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white),
                        ),
                        leading: new Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 35,
                            ),
                            new Text(
                              "Status: Approved",
                              maxLines: 4,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                // new Text(
                                //   "Provider: Bambooz Pvt ltd   ",
                                //   style: TextStyle(
                                //       fontSize: 13, color: Colors.white),
                                // ),
                                // SizedBox(
                                //   width: 2,
                                // ),
                                new Text(
                                  'Book time: 14:28',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                //Accept btn
                                FlatButton(
                                  onPressed: () {
                                    // onloginbtnpressed(context);
                                    // Navigator.of(context)
                                    //     .pushNamedAndRemoveUntil('/home', (route) => false);
                                  },
                                  color: Colors.grey,
                                  textColor: Colors.black,
                                  padding: EdgeInsets.all(0.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF22CC55),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                    ),
                                    padding: EdgeInsets.fromLTRB(
                                        10.0, 10.0, 10.0, 10.0),
                                    child: Text(
                                      'Accept',
                                      style: kSmallTextStyle,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),

                                //cancel btn
                                FlatButton(
                                  onPressed: () {
                                    // onloginbtnpressed(context);
                                    // Navigator.of(context)
                                    //     .pushNamedAndRemoveUntil('/home', (route) => false);
                                  },
                                  color: Colors.grey,
                                  textColor: Colors.black,
                                  padding: EdgeInsets.all(0.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFAC5555),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                    ),
                                    padding: EdgeInsets.fromLTRB(
                                        10.0, 10.0, 10.0, 10.0),
                                    child: Text(
                                      'Cancel',
                                      style: kSmallTextStyle,
                                    ),
                                  ),
                                ),
                              ],
                            )
                            // SizedBox(
                            //   width: 2,
                            // ),
                            // new Text(
                            //   "Contact: " + "9860919718",
                            //   style:
                            //       TextStyle(fontSize: 13, color: Colors.white),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            )),

            // Expanded(
            //     child: SizedBox(
            //   height: MediaQuery.of(context).size.height,
            //   child: ListView(children: [
            //     Container(
            //       height: 220,
            //       child: Padding(
            //         padding: const EdgeInsets.all(12.0),
            //         child: Card(
            //           color: Colors.grey,
            //           elevation: 6,
            //           child: ListTile(
            //             title: new Text(
            //               'Tiffany',
            //               style: new TextStyle(
            //                   fontSize: 20.0, color: Colors.white),
            //             ),
            //             leading: new Icon(
            //               Icons.share,
            //               color: Colors.white,
            //             ),
            //             subtitle: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 SizedBox(
            //                   height: 35,
            //                 ),
            //                 new Text(
            //                   "Status" + "Booked",
            //                   maxLines: 4,
            //                   style:
            //                       TextStyle(color: Colors.white, fontSize: 14),
            //                 ),
            //                 SizedBox(
            //                   height: 10,
            //                 ),
            //                 Row(
            //                   children: [
            //                     new Text(
            //                       "Provider: ",
            //                       style: TextStyle(
            //                           fontSize: 13, color: Colors.white),
            //                     ),
            //                     SizedBox(
            //                       width: 2,
            //                     ),
            //                     new Text(
            //                       'Book time',
            //                       style: TextStyle(
            //                           fontSize: 13, color: Colors.white),
            //                     ),
            //                   ],
            //                 ),
            //                 SizedBox(
            //                   width: 2,
            //                 ),
            //                 new Text(
            //                   "Contact: " + "9860919718",
            //                   style:
            //                       TextStyle(fontSize: 13, color: Colors.white),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ]),
            // )),
            // Expanded(
            //     child: SizedBox(
            //   height: MediaQuery.of(context).size.height,
            //   child: ListView(children: [
            //     Container(
            //       height: 220,
            //       child: Padding(
            //         padding: const EdgeInsets.all(12.0),
            //         child: Card(
            //           color: AppColors.secondaryBackground,
            //           elevation: 6,
            //           child: ListTile(
            //             title: new Text(
            //               'KFC',
            //               style: new TextStyle(
            //                   fontSize: 20.0, color: Colors.white),
            //             ),
            //             leading: new Icon(
            //               FontAwesomeIcons.blogger,
            //               color: Colors.white,
            //             ),
            //             subtitle: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 SizedBox(
            //                   height: 35,
            //                 ),
            //                 new Text(
            //                   "Status" + "Booked",
            //                   maxLines: 4,
            //                   style:
            //                       TextStyle(color: Colors.white, fontSize: 14),
            //                 ),
            //                 SizedBox(
            //                   height: 10,
            //                 ),
            //                 Row(
            //                   children: [
            //                     new Text(
            //                       "Provider: ",
            //                       style: TextStyle(
            //                           fontSize: 13, color: Colors.white),
            //                     ),
            //                     SizedBox(
            //                       width: 2,
            //                     ),
            //                     new Text(
            //                       'Book time',
            //                       style: TextStyle(
            //                           fontSize: 13, color: Colors.white),
            //                     ),
            //                   ],
            //                 ),
            //                 SizedBox(
            //                   width: 2,
            //                 ),
            //                 new Text(
            //                   "Contact: " + "9860919718",
            //                   style:
            //                       TextStyle(fontSize: 13, color: Colors.white),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ]),
            // )),
            // Expanded(
            //     child: SizedBox(
            //   height: MediaQuery.of(context).size.height,
            //   child: ListView(children: [
            //     Container(
            //       height: 220,
            //       child: Padding(
            //         padding: const EdgeInsets.all(12.0),
            //         child: Card(
            //           color: AppColors.secondaryBackground,
            //           elevation: 6,
            //           child: ListTile(
            //             title: new Text(
            //               'KFC',
            //               style: new TextStyle(
            //                   fontSize: 20.0, color: Colors.white),
            //             ),
            //             leading: new Icon(
            //               FontAwesomeIcons.blogger,
            //               color: Colors.white,
            //             ),
            //             subtitle: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 SizedBox(
            //                   height: 35,
            //                 ),
            //                 new Text(
            //                   "Status" + "Booked",
            //                   maxLines: 4,
            //                   style:
            //                       TextStyle(color: Colors.white, fontSize: 14),
            //                 ),
            //                 SizedBox(
            //                   height: 10,
            //                 ),
            //                 Row(
            //                   children: [
            //                     new Text(
            //                       "Provider: ",
            //                       style: TextStyle(
            //                           fontSize: 13, color: Colors.white),
            //                     ),
            //                     SizedBox(
            //                       width: 2,
            //                     ),
            //                     new Text(
            //                       'Book time',
            //                       style: TextStyle(
            //                           fontSize: 13, color: Colors.white),
            //                     ),
            //                   ],
            //                 ),
            //                 SizedBox(
            //                   width: 2,
            //                 ),
            //                 new Text(
            //                   "Contact: " + "9860919718",
            //                   style:
            //                       TextStyle(fontSize: 13, color: Colors.white),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ]),
            // )),
          ],
        ),
      ),
    );
  }
}

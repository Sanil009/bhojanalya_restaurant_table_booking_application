import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bhojanalaya_app/constants.dart';

class ReviewList extends StatefulWidget {
  ReviewList({Key key}) : super(key: key);

  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  // final baseUrl = env["http://192.168.1.164:8000/reviews"];
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
          automaticallyImplyLeading: true,
          backgroundColor: kRedColour,
          title: Text(
            "Reviews",
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
                          'Bambooz',
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
            //yeta samma
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

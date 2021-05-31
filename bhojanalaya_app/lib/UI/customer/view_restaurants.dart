import 'dart:convert';
import 'package:bhojanalaya_app/UI/customer/restaurant_details.dart';
import 'package:bhojanalaya_app/constants.dart';
import 'package:bhojanalaya_app/constants/urls_constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ViewRestaurants extends StatefulWidget {
  @override
  _ViewRestaurantsState createState() => _ViewRestaurantsState();
}

class _ViewRestaurantsState extends State<ViewRestaurants> {
  final baseUrl = api_url + "/auth/restaurant/";
  Future<List> fetchhotels() async {
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
    fetchhotels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Restaurants Available",
          style: kTextStyle,
        ),
        backgroundColor: kRedColour,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            _specialistsCardInfo(),
          ],
        ),
      ),
    );
  }

  FutureBuilder _specialistsCardInfo() {
    return FutureBuilder<List>(
        future: fetchhotels(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return CircularProgressIndicator();
          } else {
            return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 290,
                          childAspectRatio: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext ctx, i) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new RestaurantDetails(
                                      list: snapshot.data,
                                      index: i,
                                    )));
                          },
                          child: Card(
                            color: Colors.grey,
                            elevation: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 3),
                                SizedBox(height: 7),
                                Icon(
                                  Icons.restaurant,
                                  size: 30,
                                ),
                                Text(
                                  "Name: " + snapshot.data[i]["name"],
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 3),
                                Text("Address: " + snapshot.data[i]["address"],
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    )),
                                SizedBox(height: 3),
                                snapshot.data[i]["parking"] == true
                                    ? Card(
                                        color: Colors.green,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Parking",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ),
                                      )
                                    : Card(
                                        color: Colors.red,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "No Parking",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        );
                      }),
                ));
          }
        });
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:bhojanalaya_app/constants/urls_constants.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class GiveReviews extends StatefulWidget {
  int index;
  GiveReviews({this.index});
  @override
  _GiveReviewsState createState() => _GiveReviewsState();
}

class _GiveReviewsState extends State<GiveReviews> {
  LocalStorage storage = LocalStorage("storage-key");
  final TextEditingController comments = new TextEditingController();
  String value;
  List listItem = ["1", "2", "3", "4", "5"];
  Future postratings() async {
    var data = {
      "rating": value,
      "comments": comments.text,
      "user_id": storage.getItem("user_id"),
      "restaurant_id": widget.index
    };
    var token = storage.getItem("token");
    var url = Uri.parse(api_url + "/reviews/reviewscreate/");
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
              title: Text("Ratings sent"),
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
    print(data);
  }

  @override
  void initState() {
    print(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Give Reviews",
          style: kTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton(
                hint: Text("Give Ratings"),
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
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    labelText: 'Comments',
                    labelStyle: kTextStyle,
                  ),
                  controller: comments,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    comments.text == " " || value == null
                        ? null
                        : postratings();
                  },
                  child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}

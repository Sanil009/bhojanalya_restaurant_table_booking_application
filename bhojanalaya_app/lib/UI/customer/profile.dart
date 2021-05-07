import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final baseUrl = env["http://192.168.1.164:8000/auth/customer/"];
  // Response response;
  // Future<List> fetchCruds() async {
  //   var response = await http.get(baseUrl);
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        title: Text('Profile'),
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
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/ProfileIcon.jpg"),
                    fit: BoxFit.cover),
              ),
              child: Container(
                width: double.infinity,
                height: 200,
                child: Container(
                  alignment: Alignment(0.0, 2.5),
                  // child: CircleAvatar(
                  //   backgroundImage: AssetImage('assests/ProfileIcon.jpg'),
                  //   minRadius: 50.0,
                  //   maxRadius: 60.0,
                  // ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              "Sanil Shrestha",
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
            // Text(
            //   "Joined in 2021",
            //   style: TextStyle(
            //       fontSize: 18.0,
            //       color: Colors.white,
            //       letterSpacing: 2.0,
            //       fontWeight: FontWeight.w300),
            // ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Address: Bhaktapur",
              style: TextStyle(
                  fontSize: 15.0,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            Text(
              "Contact: 166357890",
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
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
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
                          Text(
                            "0",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w300),
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
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              elevation: 2.0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                child: Text(
                  "Points",
                  style: TextStyle(
                      letterSpacing: 2.0, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Earn a point for every booking you make",
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.black,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kRedColour,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    padding: EdgeInsets.fromLTRB(60.0, 15.0, 60.0, 15.0),
                    child: Text(
                      'Logout',
                      style: kSmallTextStyle,
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.black,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kRedColour,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                    child: Text(
                      'Delete Account',
                      style: kSmallTextStyle,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            // RaisedButton(
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            //   color: Colors.black,
            //   textColor: Colors.white,
            //   padding: EdgeInsets.all(0.0),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: kGreenColour,
            //       borderRadius: BorderRadius.all(Radius.circular(50.0)),
            //     ),
            //     padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
            //     child: Text(
            //       'Go Back',
            //       style: kSmallTextStyle,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

/* appBar: AppBar(
          title: Text('Profile'),
        ),
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('images/ProfileIcon.png'),
              minRadius: 50.0,
              maxRadius: 60.0,
            ),
            Text(
              'Sanil Shrestha',
              style: TextStyle(
                  fontFamily: 'Galada',
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Joined in 2020',
              style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontSize: 15.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade100),
            ),
          ],
        ),
      ),
    );
  }
}*/

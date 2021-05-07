import 'package:bhojanalaya_app/UI/restaurant/details/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:bhojanalaya_app/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  @override
  void initState() {
    super.initState();
    print(widget.list[widget.index]['name']);
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home', (route) => false);
          },
        ),
        title: Text(
          "Profile",
          style: kTextStyle,
        ),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.share),
          //   onPressed: () {},
          // ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/edit_restaurant_details', (route) => false);
            },
          ),
        ],
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
                        Text("Kathmandu"),
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
                                // Row(
                                //   children: <Widget>[
                                //     SmoothStarRating(
                                //       borderColor: kRedColour,
                                //       rating: 20,
                                //       // widget.list[widget.index],
                                //       // onRatingChanged: onRatingChanged,
                                //     ),
                                //     SizedBox(width: 10),
                                //     Text(
                                //         "5"), //"{widget.list[widget.index][]} reviews"
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   width: 200.0,
                          // ),
                          // Expanded(
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.end,
                          //     children: <Widget>[
                          //       Text(
                          //         "Avg Price",
                          //         style: kSmallTextStyle,
                          //       ),
                          //       SizedBox(height: 10),
                          //       // Row(
                          //       //   children: <Widget>[
                          //       avgPriceTag(context, price: price),
                          //       //   ],
                          //       // ),
                          //     ],
                          //   ),
                          // ),
                          ClipPath(
                            clipper: PricerCliper(),
                            child: Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              height: 66,
                              width: 65,
                              color: kRedColour,
                              child: Text(
                                "Rs.300", //"widget.list[widget.index][]"
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      "Type: Cafe", // widget.list[widget.index][""],
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Dish Speciality: Momo", //${widget.list[widget.index]["dish_speciality"]}
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Description: Hello, We welcome you to bambooz restaurant", //${widget.list[widget.index][""]}}
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Seating Type: Outdoor", //${widget.list[widget.index][""]}
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // Free space  10% of total height
                    OrderButton(
                      size: size,
                      press: () {},
                    ),
                    SizedBox(height: 15.0),
                    ReviewButton(
                      size: size,
                      press: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/review', (route) => false);
                      },
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.size,
    this.press,
  }) : super(key: key);

  final Size size;
  final Function press;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(20),
      width: widget.size.width * 0.8,
      // it will cover 80% of total width
      decoration: BoxDecoration(
        color: kRedColour,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/booking', (route) => false);
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SvgPicture.asset("assets/icons/bag.svg"),
                // SizedBox(width: 10),
                Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewButton extends StatefulWidget {
  const ReviewButton({
    Key key,
    @required this.size,
    this.press,
  }) : super(key: key);

  final Size size;
  final Function press;

  @override
  _ReviewButtonState createState() => _ReviewButtonState();
}

class _ReviewButtonState extends State<ReviewButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(20),
      width: widget.size.width * 0.8,
      // it will cover 80% of total width
      decoration: BoxDecoration(
        color: kRedColour,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.press,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SvgPicture.asset("assets/icons/bag.svg"),
                // SizedBox(width: 10),
                Text(
                  "Delete Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}











//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         iconTheme: IconThemeData(color: Colors.green),
//         title: new Text(
//           "Blog",
//           style: TextStyle(color: Colors.green),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: new Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Center(
//                 child: new Text(
//                   widget.list[widget.index]["email"],
//                   textAlign: TextAlign.center,
//                   style: new TextStyle(fontSize: 20.0, color: Colors.black),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: new Text(
//                   widget.list[widget.index]['email'],
//                   textAlign: TextAlign.justify,
//                   style: new TextStyle(fontSize: 14.0, color: Colors.black),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: new Text(
//                   widget.list[widget.index]['email'],
//                   textAlign: TextAlign.center,
//                   style: new TextStyle(fontSize: 13.0, color: Colors.green),
//                 ),
//               ),
//               // new Text("Contact : ${widget.list[widget.index]['contact']}",style: new TextStyle(fontSize: 20.0),),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pushNamedAndRemoveUntil(
//                 '/restaurant_dashboard', (route) => false);
//           },
//         ),
//         title: Text(
//           "My Restaurant",
//           style: kTextStyle,
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.share),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: () {
//               Navigator.of(context).pushNamedAndRemoveUntil(
//                   '/edit_restaurant_details', (route) => false);
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(child: Body()),
//     );
//   }
// }

// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   final List<String> imglist = [
//     "assets/images/restaurant.jpg",
//     "assets/images/burger.png",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final double height = MediaQuery.of(context).size.height;
//     final double width = MediaQuery.of(context).size.width;

//     return SafeArea(
//       child: Column(
//         children: <Widget>[
//           Container(
//             height: 230,
//             width: width,
//             child: CarouselSlider(
//               options: CarouselOptions(
//                 autoPlay: true,
//                 viewportFraction: 1.0,
//                 enlargeCenterPage: false,
//               ),
//               items: imglist
//                   .map((item) => Container(
//                         decoration: BoxDecoration(
//                             image: DecorationImage(
//                           image: AssetImage(item),
//                           fit: BoxFit.fill,
//                         )),
//                       ))
//                   .toList(),
//             ),
//           ),
//           ItemInfo(),
//         ],
//       ),
//     );
//   }
// }

// class ItemInfo extends StatefulWidget {
//   const ItemInfo({
//     Key key,
//   }) : super(key: key);

//   @override
//   _ItemInfoState createState() => _ItemInfoState();
// }

// class _ItemInfoState extends State<ItemInfo> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       padding: EdgeInsets.all(20),
//       width: size.width,
//       decoration: BoxDecoration(
//         color: Color(0xFF2C2C2C),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           shopeName(name: "Kathmandu"),
//           TitlePriceRating(
//             name: widget.list[widget.index]["name"],
//             numOfReviews: 24,
//             rating: 4,
//             price: 15,
//             onRatingChanged: (value) {},
//           ),
//           Text(
//             "Type: ${snapshot.data[i]["type"]}",
//             style: TextStyle(
//               height: 1.5,
//             ),
//           ),
//           SizedBox(height: 20.0),
//           Text(
//             "Dish Speciality: ",
//             style: TextStyle(
//               height: 1.5,
//             ),
//           ),
//           SizedBox(height: 20.0),
//           Text(
//             "Description: ${snapshot.data[i]["description"]}",
//             style: TextStyle(
//               height: 1.5,
//             ),
//           ),
//           SizedBox(height: 10.0),
//           Text(
//             "Type: ${snapshot.data[i]["type"]}",
//             style: TextStyle(
//               height: 1.5,
//             ),
//           ),
//           SizedBox(height: 20.0),
//           // Free space  10% of total height
//           OrderButton(
//             size: size,
//             press: () {},
//           ),
//           SizedBox(height: 15.0),
//           ReviewButton(
//             size: size,
//             press: () {
//               Navigator.of(context)
//                   .pushNamedAndRemoveUntil('/review', (route) => false);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Row shopeName({String name}) {
//     return Row(
//       children: <Widget>[
//         Icon(
//           Icons.location_on,
//           color: kRedColour,
//         ),
//         SizedBox(width: 10),
//         Text(name),
//       ],
//     );
//   }
// }

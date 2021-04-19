// import 'package:bhojanalaya_app/provider/my_provider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../constants.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class RestaurantDetails extends StatefulWidget {
//   @override
//   _RestaurantDetailsState createState() => _RestaurantDetailsState();
// }

// class _RestaurantDetailsState extends State<RestaurantDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kPrimaryColor,
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {},
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: SvgPicture.asset("assets/icons/share.svg"),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: SvgPicture.asset("assets/icons/more.svg"),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Body(),
//     );
//   }
// }

// class Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         ItemImage(
//           imgSrc: "assets/images/burger.png",
//         ),
//         Expanded(
//           child: ItemInfo(),
//         ),
//       ],
//     );
//   }
// }

// class ItemInfo extends StatelessWidget {
//   const ItemInfo({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       padding: EdgeInsets.all(20),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//       ),
//       child: Column(
//         children: <Widget>[
//           shopeName(name: "MacDonalds"),
//           TitlePriceRating(
//             name: "Cheese Burger",
//             numOfReviews: 24,
//             rating: 4,
//             price: 15,
//             onRatingChanged: (value) {},
//           ),
//           Text(
//             "Nowadays, making printed materials have become fast, easy and simple. If you want your promotional material to be an eye-catching object, you should make it colored. By way of using inkjet printer this is not hard to make. An inkjet printer is any printer that places extremely small droplets of ink onto paper to create an image.",
//             style: TextStyle(
//               height: 1.5,
//             ),
//           ),
//           SizedBox(height: size.height * 0.1),
//           // Free space  10% of total height
//           OrderButton(
//             size: size,
//             press: () {},
//           )
//         ],
//       ),
//     );
//   }

//   Row shopeName({String name}) {
//     return Row(
//       children: <Widget>[
//         Icon(
//           Icons.location_on,
//           color: ksecondaryColor,
//         ),
//         SizedBox(width: 10),
//         Text(name),
//       ],
//     );
//   }
// }

// //   bool _floating = true;
// //   bool _pinned = false;
// //   bool _snap = true;

// //   // CustomScrollView.
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         child: CustomScrollView(
// //           slivers: <Widget>[
// //             SliverAppBar(
// //               pinned: this._pinned,
// //               snap: this._snap,
// //               floating: this._floating,
// //               expandedHeight: 200,
// //               flexibleSpace: FlexibleSpaceBar(
// //                 titlePadding: EdgeInsets.zero,
// //                 centerTitle: true,
// //                 title: SizedBox(
// //                   height: 130,
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: <Widget>[
// //                       Text("Restaurant", textAlign: TextAlign.center),
// //                     ],
// //                   ),
// //                 ),
// //                 background:
// //                     Image.asset("assets/restaurant.png", fit: BoxFit.cover),
// //               ),
// //               actions: <Widget>[
// //                 IconButton(
// //                   icon: const Icon(Icons.menu),
// //                   tooltip: "Menu",
// //                   onPressed: () {
// //                     // onPressed handler
// //                   },
// //                 ),
// //               ],
// //             ),
// //             SliverFixedExtentList(
// //               itemExtent: 50,
// //               delegate: SliverChildBuilderDelegate(
// //                 (BuildContext context, int index) {
// //                   return Container(
// //                     alignment: Alignment.center,
// //                     child: Text("Index $index"),
// //                   );
// //                 },
// //               ),
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         body: CustomScrollView(
// //           slivers: <Widget>[
// //             SliverAppBar(
// //               pinned: this._pinned,
// //               snap: this._snap,
// //               floating: this._floating,
// //               expandedHeight: 160.0,
// //               flexibleSpace: FlexibleSpaceBar(
// //                 title: const Text("Restaurant"),
// //                 background: FlutterLogo(),
// //               ),
// //             ),
// //             SliverToBoxAdapter(
// //               child: Center(
// //                 child: Container(
// //                   height: 2000,
// //                   child: const Text("Here are our restaurant details."),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

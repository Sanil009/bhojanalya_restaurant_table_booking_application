// import 'package:flutter/material.dart';
// import 'package:shop_app/models/Cart.dart';
// import 'components/check_out_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class SavedScreen extends StatelessWidget {
//   static String routeName = "/cart";
//   final List<Map> demoCarts = List.generate(
//       100000, (index) => {"id": index, "product": "Product $index"}).toList();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(context),
//       body: Padding(
//         padding:
//             EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//         child: ListView.builder(
//           itemCount: demoCarts.length,
//           itemBuilder: (context, index) => Padding(
//             padding: EdgeInsets.symmetric(vertical: 10),
//             child: Dismissible(
//               key: Key(demoCarts[index].product.id.toString()),
//               direction: DismissDirection.endToStart,
//               onDismissed: (direction) {
//                 setState(() {
//                   demoCarts.removeAt(index);
//                 });
//               },
//               background: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 decoration: BoxDecoration(
//                   color: Color(0xFFFFE6E6),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Row(
//                   children: [
//                     Spacer(),
//                     SvgPicture.asset("assets/icons/Trash.svg"),
//                   ],
//                 ),
//               ),
//               child: CartCard(cart: demoCarts[index]),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       title: Column(
//         children: [
//           Text(
//             "Your Cart",
//             style: TextStyle(color: Colors.black),
//           ),
//           Text(
//             "items", //${demoCarts.length} items
//             style: Theme.of(context).textTheme.caption,
//           ),
//         ],
//       ),
//     );
//   }
// }

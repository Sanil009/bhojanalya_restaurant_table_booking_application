import 'package:bhojanalaya_app/UI/restaurant/details/components/body.dart';
import 'package:flutter/material.dart';
import 'components/app_bar.dart';

class RestaurantDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: detailsAppBar(),
      body: SingleChildScrollView(child: Body()),
    );
  }
}

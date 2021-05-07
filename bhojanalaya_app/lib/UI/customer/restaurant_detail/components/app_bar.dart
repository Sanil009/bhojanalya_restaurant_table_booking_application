import 'package:bhojanalaya_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar detailsAppBar() {
  return AppBar(
    elevation: 0,
    title: Text(
      "My Restaurant",
      style: kTextStyle,
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.share),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {},
      ),
    ],
  );
}

// SvgPicture.asset("assets/icons/share.svg")
// SvgPicture.asset("assets/icons/more.svg")

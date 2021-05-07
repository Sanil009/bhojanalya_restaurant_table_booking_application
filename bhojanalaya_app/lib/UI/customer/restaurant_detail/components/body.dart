import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../../constants.dart';
import 'item_image.dart';
import 'book_button.dart';
import 'review_button.dart';
import 'title_price_rating.dart';

class Body extends StatelessWidget {
  final List<String> imglist = [
    "assets/images/restaurant.jpg",
    "assets/images/burger.png",
  ];
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
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
          ItemInfo(),
        ],
      ),
    );
  }
}

class ItemInfo extends StatelessWidget {
  const ItemInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
        children: <Widget>[
          shopeName(name: "Kathmandu"),
          TitlePriceRating(
            name: "H20",
            numOfReviews: 24,
            rating: 4,
            price: 15,
            onRatingChanged: (value) {},
          ),
          Text(
            "Nowadays, arriving at restaurant and getting a vacant table is as dfficult as finding needle in grass field. With the growing population specially in the city, it has become hard to find the table adn have wait in the queue to find one so with this application we intend to make it easy to book table.",
            style: TextStyle(
              height: 1.5,
            ),
          ),

          Text(
            "Type: ",
            style: TextStyle(
              height: 1.5,
            ),
          ),
          SizedBox(height: 20.0),
          // Free space  10% of total height
          BookButton(
            size: size,
            press: () {},
          ),
          SizedBox(height: 15.0),
          ReviewButton(
            size: size,
            press: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/review', (route) => false);
            },
          ),
        ],
      ),
    );
  }

  Row shopeName({String name}) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.location_on,
          color: kRedColour,
        ),
        SizedBox(width: 10),
        Text(name),
      ],
    );
  }
}

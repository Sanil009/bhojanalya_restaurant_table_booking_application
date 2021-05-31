import 'package:bhojanalaya_app/UI/authentication/forgotpassword.dart';
import 'package:bhojanalaya_app/UI/customer/booking_list.dart';
import 'package:bhojanalaya_app/UI/customer/view_restaurants.dart';
import 'package:flutter/cupertino.dart';

import 'UI/authentication/login.dart';
import 'UI/authentication/signup.dart';
import 'UI/authentication/reset_password.dart';

import 'UI/customer/edit_details.dart';
import 'UI/customer/generatepdf.dart';
import 'UI/customer/restaurant_details.dart';
// import 'UI/customer/review.dart';
import 'UI/customer/home.dart';
import 'UI/customer/settings.dart';
import 'UI/customer/profile.dart';

import 'UI/restaurant/restaurant_profile.dart';
import 'UI/restaurant/restaurant_dashboard.dart';
import 'UI/restaurant/restaurant_settings.dart';
import 'UI/screens/first_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/first_screen': (BuildContext context) => new FirstPage(),

  // Authentication
  '/login': (BuildContext context) => new LoginPage(),
  '/signup': (BuildContext context) => new Signup(),
  '/reset': (BuildContext context) => new ResetPasswordPage(),
  '/forgot-pw': (BuildContext context) => new ForgotPasswordPage(),
  // '/restaurant_register': (BuildContext context) =>
  //     new RestaurantRegisterPage(),

  // Customer
  '/profile': (BuildContext context) => new ProfilePage(),
  '/settings': (BuildContext context) => new SettingsPage(),
  '/home': (BuildContext context) => new HomePage(),
  // '/review': (BuildContext context) => new ReviewPage(),
  '/edit_details': (BuildContext context) => new EditDetailsPage(),
  '/booking_list': (BuildContext context) => new BookingList(),
  '/restaurant_details': (BuildContext context) => new RestaurantDetails(),
  '/view-restaurants': (BuildContext context) => new ViewRestaurants(),
  '/generate_pdf': (BuildContext context) => new GeneratePDF(),

  // Restaurant
  '/restaurant_dashboard': (BuildContext context) => new RestaurantDashboard(),
  '/restaurant_profile': (BuildContext context) => new RestaurantProfile(),
  '/restaurant_settings': (BuildContext context) =>
      new RestaurantSettingsPage(),
};

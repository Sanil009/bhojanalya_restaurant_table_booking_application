import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class RegisterServices {
  Dio dio = Dio();
  TextEditingController email = new TextEditingController();
  Future<void> registerUser(String email, String password) async {
    try {
      dynamic result = dio.post(
        'path',
        data: {
          "email": email,
          "password": password,
        },
      );
      return result;
    }
    // on dio.DioError(Exception e) {
    //   return e.message;
    // }
    catch (e) {
      return null;
    }
  }
}

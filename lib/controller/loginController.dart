// ignore_for_file: file_names, avoid_print

import 'package:food_dairy_app/controller/sqllite.dart';
import 'package:food_dairy_app/screen/home_screen.dart';
import 'package:food_dairy_app/widget/constants/staticdata.dart';
import 'package:food_dairy_app/model.dart/UserModel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  TextEditingController email =
      TextEditingController();
  TextEditingController password = TextEditingController();
  Future<UserModel?> getUser(String email, String password, context) async {
    print("dataaaa");
    UserModel? model =
        await DBHelper.getUserByEmailAndPassword(email, password);

    if (model != null) {
      print("dskjfhj$model");
      StaticData.model = model;
      StaticData.id = model.id;
      StaticData.storeCredentials(email, password);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => true,
      );
    } else {
      print("kjsdhfjkshdf");
      return null;
    }
    return null;
  }
}

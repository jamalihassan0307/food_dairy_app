import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_dairy_app/controller/sqllite.dart';
import 'package:food_dairy_app/model.dart/UserModel.dart';
import 'package:food_dairy_app/widget/constants/staticdata.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController dob = TextEditingController();
  File? image;
  updatedata() async {
    if (username.text.isNotEmpty &&
        email.text.isNotEmpty &&
        image != null &&
        password.text.isNotEmpty &&
        phone.text.isNotEmpty &&
        dob.text.isNotEmpty) {
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      UserModel model = UserModel(
        password: password.text,
        image: image!.path,
        username: username.text,
        id: id,
        email: email.text,
        phone: phone.text,
        dob: dob.text,
      );

      await DBHelper.updateUser(
        model,
      );

      StaticData.model = model;
      StaticData.id = id;
      //  update();
      // clearField();
    } else {
      Fluttertoast.showToast(
        msg: "Please fill all fields!",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 17,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  void clearField() {
    username.clear();
    email.clear();
    password.clear();
    phone.clear();
    dob.clear();
  }
}

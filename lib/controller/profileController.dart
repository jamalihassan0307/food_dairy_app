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

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    if (StaticData.model != null) {
      username.text = StaticData.model!.username;
      email.text = StaticData.model!.email;
      phone.text = StaticData.model!.phone;
      dob.text = StaticData.model!.dob;
      // Don't load password for security reasons
      image = File(StaticData.model!.image);
      update();
    }
  }

  Future<void> updatedata() async {
    if (username.text.isEmpty ||
        email.text.isEmpty ||
        phone.text.isEmpty ||
        dob.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill all required fields!",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 17,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    try {
      String id = StaticData.id ?? DateTime.now().millisecondsSinceEpoch.toString();
      UserModel model = UserModel(
        password: password.text.isNotEmpty ? password.text : StaticData.model!.password,
        image: image?.path ?? StaticData.model!.image,
        username: username.text,
        id: id,
        email: email.text,
        phone: phone.text,
        dob: dob.text,
      );

      await DBHelper.updateUser(model);
      StaticData.model = model;
      StaticData.id = id;

      Fluttertoast.showToast(
        msg: "Profile updated successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 17,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG,
      );

      // Clear password field after successful update
      password.clear();
      update();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to update profile. Please try again.",
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
    image = null;
    update();
  }
}

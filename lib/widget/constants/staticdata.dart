import 'dart:convert';

import 'package:food_dairy_app/controller/loginController.dart';
import 'package:food_dairy_app/model.dart/RecppeModel.dart';
import 'package:food_dairy_app/model.dart/UserModel.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaticData {
  static String? id;
  static List<Recipe>? yourrecipe;
  static UserModel? model;
  static Future<String?> fileToAsset(String filePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/assets.json';
    final File assetsFile = File(filePath);

    if (await assetsFile.exists()) {
      final String assetsString = await assetsFile.readAsString();
      final Map<String, dynamic> assetsMap = jsonDecode(assetsString);
      return assetsMap[filePath];
    }

    return null;
  }

  static Future<File> assetToFile(String assetPath) async {
    String directory = (await getApplicationDocumentsDirectory()).path;

    List<String> pathParts = assetPath.split('/');
    String fileName = pathParts.last;

    String filePath = '$directory/$fileName';

    File existingFile = File(filePath);
    if (await existingFile.exists()) {
      return existingFile;
    }

    ByteData data = await rootBundle.load(assetPath);
    List<int> bytes = data.buffer.asUint8List();

    await File(filePath).writeAsBytes(bytes);

    return File(filePath);
  }

  static Future<void> storeCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  static Future<Map<String, String>> retrieveCredentials(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    if (email != null && password != null) {
      LoginController.to.getUser(email, password, context);
    } else {
      print("null datya");
    }
    return {'email': email ?? '', 'password': password ?? ''};
  }
}

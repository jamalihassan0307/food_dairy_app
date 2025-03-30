import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_dairy_app/controller/recipe_controller.dart';
import 'package:food_dairy_app/screen/splash_screen.dart';
import 'package:food_dairy_app/widget/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize GetX controller
  Get.put(RecipeController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Food Diary App',
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      home: const SplashScreen(),
    );
  }
}

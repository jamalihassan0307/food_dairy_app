import 'package:flutter/material.dart';
import 'package:food_dairy_app/screen/loginScreen.dart';
import 'package:food_dairy_app/widget/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Diary App',
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      home: const LoginScreen(),
    );
  }
}

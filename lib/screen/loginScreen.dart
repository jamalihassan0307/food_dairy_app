// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:food_dairy_app/controller/loginController.dart';
import 'package:food_dairy_app/screen/SignupScreen.dart';
import 'package:food_dairy_app/widget/constants/staticdata.dart';
import 'package:food_dairy_app/widget/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    Get.put(LoginController());
    StaticData.retrieveCredentials(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GetBuilder<LoginController>(builder: (obj) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.gradientStart.withOpacity(0.9),
                AppColors.gradientEnd.withOpacity(0.95),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Top Image Section with Overlay
                Stack(
                  children: [
                    // Image Container
                    Container(
                      height: height * 0.45,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        child: Image.asset(
                          "assets/images/dish.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Gradient Overlay
                    Container(
                      height: height * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.gradientStart.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                    // Back Button
                    SafeArea(
                      child: FadeInDown(
                        duration: const Duration(milliseconds: 800),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.3),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                // Login Form Section
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInDown(
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 800),
                        child: Text(
                          "Welcome to\nFood Diary",
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        duration: const Duration(milliseconds: 800),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white.withOpacity(0.2)),
                          ),
                          child: TextFormField(
                            controller: obj.email,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined, color: Colors.white70),
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.white70),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FadeInUp(
                        delay: const Duration(milliseconds: 600),
                        duration: const Duration(milliseconds: 800),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white.withOpacity(0.2)),
                          ),
                          child: TextFormField(
                            controller: obj.password,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline, color: Colors.white70),
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.white70),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      FadeInUp(
                        delay: const Duration(milliseconds: 800),
                        duration: const Duration(milliseconds: 800),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.white.withOpacity(0.7)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      FadeInUp(
                        delay: const Duration(milliseconds: 1000),
                        duration: const Duration(milliseconds: 800),
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.secondaryColor, Color(0xFFFF8F71)],
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.secondaryColor.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () => obj.getUser(obj.email.text, obj.password.text, context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      FadeInUp(
                        delay: const Duration(milliseconds: 1200),
                        duration: const Duration(milliseconds: 800),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(color: Colors.white.withOpacity(0.7)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUp(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

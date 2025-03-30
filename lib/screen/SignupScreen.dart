// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:food_dairy_app/controller/signupController.dart';
import 'package:food_dairy_app/widget/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    Get.put(SignupController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: GetBuilder<SignupController>(
        initState: (state) {
        Get.put(SignupController());
        }, 
        builder: (obj) {
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
                        height: height * 0.35,
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
                        height: height * 0.35,
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

                  // Signup Form Section
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInDown(
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 800),
                          child: Text(
                            "Create Account",
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildInputField(
                          controller: obj.username,
                          hint: "Username",
                          icon: Icons.person_outline,
                          delay: 400,
                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          controller: obj.email,
                          hint: "Email",
                          icon: Icons.email_outlined,
                          delay: 500,
                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          controller: obj.password,
                          hint: "Password",
                          icon: Icons.lock_outline,
                          isPassword: true,
                          delay: 600,
                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          controller: obj.phone,
                          hint: "Phone",
                          icon: Icons.phone_outlined,
                          delay: 700,
                        ),
                        const SizedBox(height: 16),
                        _buildInputField(
                          controller: obj.dob,
                          hint: "Date of birth",
                          icon: Icons.calendar_today_outlined,
                          delay: 800,
                        ),
                        const SizedBox(height: 32),
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
                              onPressed: () => obj.register(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                "Sign Up",
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
                          child: Column(
                      children: [
                        Text(
                                "By signing up, you agree to our",
                          style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Terms and Conditions",
                              style: TextStyle(
                                    color: AppColors.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
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
        },
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    required int delay,
  }) {
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      duration: const Duration(milliseconds: 800),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: TextFormField(
          controller: controller,
          obscureText: isPassword,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.white70),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white70),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
      ),
    );
  }
}

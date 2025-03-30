// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:food_dairy_app/controller/profileController.dart';
import 'package:food_dairy_app/widget/constants/staticdata.dart';
import 'package:food_dairy_app/widget/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // Get.put(ProfileController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (obj) {
          return SingleChildScrollView(
            child: Container(
              height: height,
              width: width,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SafeArea(
                child: Column(
                  children: [
                    // Top Bar with Back Button
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                          ),
                          const Spacer(),
                          Text(
                            "Profile",
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),

                    // Profile Image and Name Section
                    FadeInDown(
                      duration: const Duration(milliseconds: 800),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryColor.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: FutureBuilder(
                                  future: StaticData.assetToFile(StaticData.model!.image),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                        ),
                                      );
                                    }

                                    if (snapshot.hasError) {
                                      return const Icon(
                                        Icons.error_outline,
                                        color: AppColors.primaryColor,
                                        size: 40,
                                      );
                                    }

                                    return ClipOval(
                                      child: Image.file(
                                        snapshot.requireData,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            obj.username.text.isEmpty ? "Your Name" : obj.username.text,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Profile Stats
                    FadeInDown(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 800),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem(
                              icon: Icons.restaurant_menu,
                              label: "Meals",
                              value: "12",
                            ),
                            _buildStatItem(
                              icon: Icons.local_fire_department,
                              label: "Calories",
                              value: "1,200",
                            ),
                            _buildStatItem(
                              icon: Icons.fitness_center,
                              label: "Protein",
                              value: "60g",
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Profile Information Section
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 800),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Profile Information",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              controller: obj.username,
                              icon: Icons.person_outline,
                              hint: "Username",
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              controller: obj.email,
                              icon: Icons.email_outlined,
                              hint: "Email",
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              controller: obj.phone,
                              icon: Icons.phone_outlined,
                              hint: "Phone",
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              controller: obj.dob,
                              icon: Icons.calendar_today_outlined,
                              hint: "Date of birth",
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (picked != null) {
                                  obj.dob.text = "${picked.day}/${picked.month}/${picked.year}";
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Security Section
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      duration: const Duration(milliseconds: 800),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Security",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              controller: obj.password,
                              icon: Icons.lock_outline,
                              hint: "Change Password",
                              isPassword: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Update Button
                    FadeInUp(
                      delay: const Duration(milliseconds: 800),
                      duration: const Duration(milliseconds: 800),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: InkWell(
                          onTap: () => obj.updatedata(),
                          child: Container(
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryColor,
                                  AppColors.secondaryColor,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                "Update Profile",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            icon,
            color: AppColors.primaryColor,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondaryColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool isPassword = false,
    TextInputType? keyboardType,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        onTap: onTap,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          prefixIcon: Icon(icon, color: AppColors.primaryColor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}

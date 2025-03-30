// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:food_dairy_app/controller/recipe_repository.dart';
import 'package:food_dairy_app/controller/sqllite.dart';
import 'package:food_dairy_app/screen/nev_bar/page1.dart';
import 'package:food_dairy_app/screen/nev_bar/page2.dart';
import 'package:food_dairy_app/screen/addfood.dart';
import 'package:food_dairy_app/screen/nev_bar/profile.dart';
import 'package:food_dairy_app/screen/settingScreen.dart';
import 'package:food_dairy_app/widget/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Get.put(RecipeRepository());
    DBHelper.getAllRecipes();
    super.initState();
  }

  PageController page = PageController();
  int currentIndex = 0;

  final List<IconData> icons = [
    Icons.home_rounded,
    Icons.analytics_rounded,
    Icons.person_rounded,
  ];

  final List<String> labels = [
    'Home',
    'Analytics',
    'Profile',
  ];

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Page View
          PageView(
            controller: page,
            onPageChanged: (index) => setState(() => currentIndex = index),
            children: const [Page1(), Page2(), SettingsScreen()],
          ),
          
          // Add Recipe Button
          Positioned(
            bottom: 90,
            right: 20,
            child: FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddFood()),
                  );
                },
                backgroundColor: AppColors.primaryColor,
                child: const Icon(Icons.add, size: 28),
              ),
            ),
          ),

          // Bottom Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: Container(
                height: 65,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    icons.length,
                    (index) => _buildNavItem(icons[index], labels[index], index),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => currentIndex = index);
        page.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor.withOpacity(0.5) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.primaryColor : Colors.grey,
                size: 22,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primaryColor : Colors.grey,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

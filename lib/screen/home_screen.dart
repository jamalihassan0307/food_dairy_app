// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:food_dairy_app/controller/recipe_repository.dart';
import 'package:food_dairy_app/controller/sqllite.dart';
import 'package:food_dairy_app/screen/nev_bar/page1.dart';
import 'package:food_dairy_app/screen/nev_bar/page2.dart';
import 'package:food_dairy_app/screen/addfood.dart';
import 'package:food_dairy_app/screen/nev_bar/profile.dart';
import 'package:food_dairy_app/screen/settingScreen.dart';
import 'package:get/get.dart';

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

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageView(
        controller: page,
        onPageChanged: (index) => setState(() => currentIndex = index),
        children: const [Page1(), Page2(), SettingsScreen()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.map_outlined, 0),
            _buildNavItem(Icons.data_exploration_outlined, 1),
            _buildNavItem(Icons.person, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() => currentIndex = index);
        page.jumpToPage(index);
      },
      child: Container(
        width: index == 1 ? width * 0.3 : width * 0.2,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Icon(
          icon,
          color: currentIndex == index ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}

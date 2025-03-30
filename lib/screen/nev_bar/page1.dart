// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:flutter/material.dart';
import 'package:food_dairy_app/model.dart/RecipeModel.dart';
import 'package:food_dairy_app/controller/recipe_repository.dart';
import 'package:food_dairy_app/widget/constants/staticdata.dart';
import 'package:food_dairy_app/widget/loaded_recipes_widget.dart';
import 'package:food_dairy_app/widget/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  var height, width;
  final TextEditingController _searchController = TextEditingController();
  List<RecipeModel> filteredRecipes = [];

  final List<String> categories = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
    'Desserts',
  ];

  int selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    // Combine default recipes and user recipes with proper typing
    List<RecipeModel> userRecipes = StaticData.yourrecipe ?? [];
    filteredRecipes = [...makeRecipes, ...userRecipes];
    _searchController.addListener(_filterRecipes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterRecipes() {
    setState(() {
      String searchQuery = _searchController.text.toLowerCase();
      String selectedCategory = categories[selectedCategoryIndex].toLowerCase();

      // Filter from both sources with proper typing
      List<RecipeModel> userRecipes = StaticData.yourrecipe ?? [];
      List<RecipeModel> allRecipes = [...makeRecipes, ...userRecipes];
      
      filteredRecipes = allRecipes.where((recipe) {
        bool matchesSearch = recipe.name.toLowerCase().contains(searchQuery);
        bool matchesCategory = selectedCategory == 'all' || 
                             recipe.name.toLowerCase().contains(selectedCategory);
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _onCategorySelected(int index) {
    setState(() {
      selectedCategoryIndex = index;
      _filterRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return GetBuilder<RecipeRepository>(
      initState: (state) {},
      builder: (obj) {
        return Container(
          height: height,
          width: width,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Header Section
                  FadeInDown(
                    duration: const Duration(milliseconds: 800),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello,",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.textSecondaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${StaticData.model!.username} 👋",
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        FutureBuilder(
                          future: StaticData.assetToFile(StaticData.model!.image),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.primaryColor,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              );
                            }

                            if (snapshot.hasError) {
                              print("Error: ${snapshot.error}");
                              return const CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.primaryColor,
                                child: Icon(Icons.error_outline, color: Colors.white),
                              );
                            }

                            return Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryColor.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.primaryColor,
                                backgroundImage: FileImage(snapshot.requireData),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Search and Filter Section
                  FadeInDown(
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 800),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.white70),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "Search recipes...",
                                hintStyle: TextStyle(color: Colors.white70),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.tune, color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Categories
                  FadeInDown(
                    delay: const Duration(milliseconds: 400),
                    duration: const Duration(milliseconds: 800),
                    child: SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => _onCategorySelected(index),
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: selectedCategoryIndex == index
                                    ? AppColors.secondaryColor
                                    : AppColors.cardColor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: selectedCategoryIndex == index
                                      ? AppColors.secondaryColor
                                      : Colors.white.withOpacity(0.1),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  categories[index],
                                  style: TextStyle(
                                    color: selectedCategoryIndex == index
                                        ? Colors.white
                                        : Colors.white70,
                                    fontWeight: selectedCategoryIndex == index
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Recipe Count
                  FadeInDown(
                    delay: const Duration(milliseconds: 600),
                    duration: const Duration(milliseconds: 800),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Recipes",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${filteredRecipes.length} Recipes",
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Recipes List
                  Expanded(
                    child: FadeInUp(
                      delay: const Duration(milliseconds: 800),
                      duration: const Duration(milliseconds: 800),
                      child: LoadedRecipesWidget(
                        recipes: filteredRecipes,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

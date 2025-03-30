// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:food_dairy_app/model.dart/RecipeModel.dart';
import 'package:food_dairy_app/screen/recipe_details_screen.dart';
import 'package:food_dairy_app/widget/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:io';

class LoadedRecipesWidget extends StatelessWidget {
  final List<RecipeModel> recipes;
  
  final bool isFromYourRecipes;
  
  const LoadedRecipesWidget({
    super.key,
    required this.recipes,
    required this.isFromYourRecipes,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return FadeInUp(
          delay: Duration(milliseconds: index * 200),
          duration: const Duration(milliseconds: 800),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailsScreen(
                    recipe: recipes[index],
                    isFromYourRecipes: isFromYourRecipes,
                  ),
                ),
              );
            },
            child: RecipeCardWidget(
              recipe: recipes[index],
            ),
          ),
        );
      },
    );
  }
}

class RecipeCardWidget extends StatelessWidget {
  final RecipeModel recipe;
  RecipeCardWidget({
    super.key,
    required this.recipe,
  });

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.24,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width * 0.35,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: recipe.imageUrl.contains("assets/")
                  ? Image.asset(
                      recipe.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print('Error loading asset image: $error');
                        return Container(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          child: Icon(
                            Icons.restaurant,
                            color: AppColors.primaryColor,
                            size: 40,
                          ),
                        );
                      },
                    )
                  : Image.file(
                      File(recipe.imageUrl),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print('Error loading file image: $error');
                        return Container(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          child: Icon(
                            Icons.restaurant,
                            color: AppColors.primaryColor,
                            size: 40,
                          ),
                        );
                      },
                    ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.local_fire_department,
                              size: 16,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${recipe.calories} cal",
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.fitness_center,
                              size: 16,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${recipe.protein}g",
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    recipe.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    recipe.description,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedImageWidget extends StatelessWidget {
  final String imageUrl;
  AnimatedImageWidget({
    super.key,
    required this.imageUrl,
  });

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height * 0.2,
      width: width * 0.4,
      child: Image.asset(
        imageUrl,
        fit: BoxFit.contain,
        alignment: Alignment.center,
      ),
    );
  }
}

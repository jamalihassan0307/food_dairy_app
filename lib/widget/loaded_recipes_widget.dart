// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:food_dairy_app/model.dart/RecppeModel.dart';
import 'package:food_dairy_app/screen/recipe_details_screen.dart';

class LoadedRecipesWidget extends StatelessWidget {
  final List<Recipe> recipes;
  const LoadedRecipesWidget({
    super.key,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailsScreen(
                  recipe: recipes[index],
                ),
              ),
            );
          },
          child: RecipeCardWidget(
            recipe: recipes[index],
          ),
        );
      },
    );
  }
}

class RecipeCardWidget extends StatelessWidget {
  final Recipe recipe;
  RecipeCardWidget({
    super.key,
    required this.recipe,
  });

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height * 0.24,
      width: width,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimatedImageWidget(
              imageUrl: recipe.imageUrl,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("${recipe.calories}cal \t\t\t\t${recipe.protein}protein",
                    style: Theme.of(context).textTheme.labelMedium),
                SizedBox(
                    width: width * 0.4,
                    child: Text(recipe.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        softWrap: true,
                        style: Theme.of(context).textTheme.titleLarge)),
                SizedBox(
                  width: width * 0.4,
                  child: Text(recipe.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      softWrap: true,
                      style: Theme.of(context).textTheme.labelLarge),
                ),
              ],
            )
          ],
        ),
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

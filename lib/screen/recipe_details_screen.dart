// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:food_dairy_app/model.dart/RecipeModel.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final RecipeModel recipe;
  RecipeDetailsScreen({
    super.key,
    required this.recipe,
  });

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 25,
                ),
              ),
              Text(
                recipe.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_outline,
                    size: 25,
                  ))
            ]),
            SizedBox(
              height: height * 0.04,
            ),
            Container(
                height: height * 0.31,
                width: width * 0.8,
                alignment: Alignment.center,
                child: Image.asset(
                  recipe.imageUrl,
                  fit: BoxFit.contain,
                )),
            SizedBox(
              height: height * 0.06,
            ),
            Container(
              width: width,
              height: height * 0.1,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white30, width: 1.3),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InfoViewer(name: 'Kcal', amount: recipe.calories),
                    InfoViewer(name: 'Protein', amount: recipe.protein),
                    InfoViewer(name: 'Prep Time', amount: recipe.prepTime),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

class InfoViewer extends StatelessWidget {
  final String name;
  final String amount;
  const InfoViewer({
    super.key,
    required this.name,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          amount.toString(),
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 18,
              ),
        ),
        Text(name, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

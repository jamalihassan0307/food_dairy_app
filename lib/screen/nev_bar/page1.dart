// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:flutter/material.dart';
import 'package:food_dairy_app/model.dart/RecppeModel.dart';
import 'package:food_dairy_app/controller/recipe_repository.dart';
import 'package:food_dairy_app/widget/constants/staticdata.dart';
import 'package:food_dairy_app/widget/loaded_recipes_widget.dart';
import 'package:get/get.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return GetBuilder<RecipeRepository>(
        initState: (state) {},
        builder: (obj) {
          return SizedBox(
            height: height,
            width: width,
            child: Center(
              child: SizedBox(
                height: height,
                width: width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${StaticData.model!.username} 👋 ",
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        FutureBuilder(
                            future:
                                StaticData.assetToFile(StaticData.model!.image),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              if (snapshot.hasError) {
                                print("Error: /${snapshot.error}");
                                return Text('Error: /${snapshot.error}');
                              }

                              return CircleAvatar(
                                  radius: 45,
                                  backgroundColor: Colors.blue.shade900,
                                  backgroundImage:
                                      FileImage(snapshot.requireData));
                            })
                      ],
                    ),
                    // SizedBox(height: height * 0.02),
                    // SizedBox(
                    //   height: 45,
                    //   width: width,
                    //   child: ListView(
                    //     scrollDirection: Axis.horizontal,
                    //     padding: const EdgeInsets.only(left: 15),
                    //     children: List.generate(
                    //       _categories.length,
                    //       (index) => _categories[index],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: height * 0.02),
                    Text(
                      "10 Recipes",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Expanded(
                      child: LoadedRecipesWidget(
                        recipes: makeRecipes,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

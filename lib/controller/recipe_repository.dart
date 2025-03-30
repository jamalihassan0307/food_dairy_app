import 'dart:io';

// import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_dairy_app/controller/sqllite.dart';
import 'package:food_dairy_app/model.dart/RecipeModel.dart';
import 'package:food_dairy_app/widget/constants/staticdata.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RecipeRepository extends GetxController {
  static RecipeRepository get to => Get.find();
  TextEditingController name = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController cal = TextEditingController();
  TextEditingController protein = TextEditingController();
  TextEditingController pre = TextEditingController();
  
  final List<String> categories = [
    'Italian',
    'Fast Food',
    'Desserts',
    'Asian',
    'Main Dishes',
    'Pasta',
    'Salads',
    'Mexican',
  ];
  
  String selectedCategory = 'Main Dishes';
  int index = 0;
  File? image;

  // Add methods to calculate statistics
  int getTotalCalories() {
    if (StaticData.yourrecipe == null) return 0;
    return StaticData.yourrecipe!.fold(0, (sum, recipe) => sum + int.parse(recipe.calories));
  }

  int getTotalProtein() {
    if (StaticData.yourrecipe == null) return 0;
    return StaticData.yourrecipe!.fold(0, (sum, recipe) => sum + int.parse(recipe.protein));
  }

  int getMealsCount() {
    return StaticData.yourrecipe?.length ?? 0;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
      update();
    }
  }

  void setCategory(String category) {
    selectedCategory = category;
    update();
  }

  Future<void> addRecipe(context) async {
    if (name.text.isNotEmpty &&
        des.text.isNotEmpty &&
        image != null &&
        cal.text.isNotEmpty &&
        protein.text.isNotEmpty &&
        pre.text.isNotEmpty) {
      String id = DateTime.now().microsecond.toString();
      RecipeModel model = RecipeModel(
        category: selectedCategory,
        id: id,
        name: name.text,
        description: des.text,
        imageUrl: StaticData.fileToAsset(image!.path).toString(),
        calories: cal.text,
        protein: protein.text,
        prepTime: pre.text
      );
      
      await DBHelper.insertRecipe(model);
      await DBHelper.getAllRecipes(); // Refresh the recipes list
      update(); // Update the UI
      
      Fluttertoast.showToast(
        msg: "Recipe Added Successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 17,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG,
      );
      cleardata();
    } else {
      Fluttertoast.showToast(
        msg: "Please fill all fields!",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 17,
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  cleardata() {
    name.clear();
    des.clear();
    image = null;
    cal.clear();
    pre.clear();
    protein.clear();
    selectedCategory = 'Main Dishes';
    update();
  }
}





// import 'dart:convert';

// import 'package:dribbble_challenge/src/recipes/domain/recipe.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class RecipeRepository {
//   Future<List<Recipe>> loadRecipes(
//       {String filePath = "assets/recipes.json"}) async {
//     final response = await rootBundle.loadString(filePath);
//     final recipes =
//         (jsonDecode(response) as List).map((e) => Recipe.fromJson(e)).toList();
//     return recipes;
//   }
// }

// final repositoryProvider = Provider<RecipeRepository>((ref) {
//   return RecipeRepository();
// });

// final recipesProvider = FutureProvider<List<Recipe>>((ref) async {
//   return ref.watch(repositoryProvider).loadRecipes();
// });

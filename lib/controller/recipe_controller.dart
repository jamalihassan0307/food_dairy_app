import 'package:get/get.dart';
import 'package:food_dairy_app/model.dart/RecipeModel.dart';
import 'package:food_dairy_app/widget/constants/staticdata.dart';

class RecipeController extends GetxController {
  var recipes = <RecipeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (StaticData.yourrecipe != null) {
      recipes.value = StaticData.yourrecipe!;
    }
  }

  void addRecipe(RecipeModel recipe) {
    recipes.add(recipe);
    StaticData.yourrecipe = recipes;
  }

  void removeRecipe(RecipeModel recipe) {
    recipes.removeWhere((r) => r.id == recipe.id);
    StaticData.yourrecipe = recipes;
  }

  void updateRecipes(List<RecipeModel> newRecipes) {
    recipes.value = newRecipes;
    StaticData.yourrecipe = recipes;
  }
} 
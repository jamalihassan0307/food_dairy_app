import 'package:flutter/material.dart';
import 'package:food_dairy_app/controller/recipe_repository.dart';
import 'package:food_dairy_app/widget/theme/app_colors.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  @override
  void initState() {
    Get.put(RecipeRepository());
    super.initState();
  }

  final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GetBuilder<RecipeRepository>(builder: (obj) {
      return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  FadeInDown(
                    duration: const Duration(milliseconds: 800),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Add New Recipe",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Image Picker
                  FadeInDown(
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 800),
                    child: Center(
                      child: InkWell(
                        onTap: () => obj.pickImage(),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: obj.image == null
                              ? const Icon(Icons.add_a_photo, color: Colors.white, size: 40)
                              : ClipOval(
                                  child: Image.file(
                                    obj.image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Form Fields
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    duration: const Duration(milliseconds: 800),
                    child: Form(
                      key: form,
                      child: Column(
                        children: [
                          _buildTextField(
                            controller: obj.name,
                            hint: "Recipe Name",
                            icon: Icons.restaurant,
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(
                            controller: obj.des,
                            hint: "Description",
                            icon: Icons.description,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  controller: obj.cal,
                                  hint: "Calories",
                                  icon: Icons.local_fire_department,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: _buildTextField(
                                  controller: obj.protein,
                                  hint: "Protein (g)",
                                  icon: Icons.fitness_center,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(
                            controller: obj.pre,
                            hint: "Preparation Time (min)",
                            icon: Icons.timer,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Add Button
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    duration: const Duration(milliseconds: 800),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () => obj.addRecipe(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          "Add Recipe",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
        ),
      );
    });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int? maxLines,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 16,
          ),
          prefixIcon: Icon(icon, color: AppColors.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
      ),
    );
  }
}

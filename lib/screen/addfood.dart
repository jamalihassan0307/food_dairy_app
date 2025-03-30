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
    return GetBuilder<RecipeRepository>(builder: (obj) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.primaryColor),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Add New Recipe",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
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
                            color: AppColors.primaryColor.withOpacity(0.1),
                            border: Border.all(color: AppColors.primaryColor, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.2),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: obj.image == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_a_photo, color: AppColors.primaryColor, size: 40),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Add Photo",
                                      style: TextStyle(
                                        color: AppColors.primaryColor.withOpacity(0.8),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
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
                          
                          // Category Selection
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.white.withOpacity(0.1)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                value: obj.selectedCategory,
                                decoration: InputDecoration(
                                  hintText: "Select Category",
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 16,
                                  ),
                                  prefixIcon: Icon(Icons.category, color: Colors.white.withOpacity(0.7)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.cardColor,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
                                ),
                                dropdownColor: AppColors.cardColor,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                items: obj.categories.map((String category) {
                                  return DropdownMenuItem<String>(
                                    value: category,
                                    child: Text(category),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    obj.setCategory(newValue);
                                  }
                                },
                              ),
                            ),
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
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.primaryColor.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => obj.addRecipe(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Add Recipe",
                          style: TextStyle(
                            color: Colors.white,
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
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
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
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 16,
          ),
          prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.7)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.cardColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
      ),
    );
  }
}

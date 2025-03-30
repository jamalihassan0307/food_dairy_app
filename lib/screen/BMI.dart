// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, library_private_types_in_public_api
// ignore_for_file: file_names, prefer_const_constructors
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_dairy_app/widget/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';

enum Gender { male, female, unSelected }

class Logic {
  double calculateBMI(int height, int weight) {
    double bmi = weight / pow(height / 100, 2);
    return bmi;
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  Gender selectedCard = Gender.unSelected;
  int sliderValue = 0;
  int weight = 40;
  int Age = 10;
  // int height=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "BMI Calculator",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
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
                  child: Text(
                    "Calculate your BMI",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Gender Selection
                FadeInDown(
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 800),
              child: Row(
                children: [
                  Expanded(
                        child: _buildGenderCard(
                          icon: FontAwesomeIcons.mars,
                          label: 'MALE',
                          isSelected: selectedCard == Gender.male,
                          onTap: () => setState(() => selectedCard = Gender.male),
                            ),
                      ),
                      const SizedBox(width: 20),
                  Expanded(
                        child: _buildGenderCard(
                          icon: FontAwesomeIcons.venus,
                          label: 'FEMALE',
                          isSelected: selectedCard == Gender.female,
                          onTap: () => setState(() => selectedCard = Gender.female),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Height Slider
                FadeInDown(
                  delay: const Duration(milliseconds: 400),
                  duration: const Duration(milliseconds: 800),
                  child: _buildInputCard(
                    title: 'Height',
                    value: sliderValue,
                    unit: 'cm',
                    child: Column(
                children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildControlButton(
                              icon: FontAwesomeIcons.minus,
                              onTap: () => setState(() {
                                if (sliderValue > 0) sliderValue--;
                              }),
                            ),
                            Expanded(
                              child: Slider(
                                  value: sliderValue.toDouble(),
                                  min: 0.0,
                                  max: 250.0,
                                  onChanged: (value) {
                                  setState(() => sliderValue = value.toInt());
                                  },
                                activeColor: AppColors.primaryColor,
                                inactiveColor: AppColors.primaryColor.withOpacity(0.2),
                              ),
                                ),
                            _buildControlButton(
                              icon: FontAwesomeIcons.plus,
                              onTap: () => setState(() {
                                if (sliderValue < 250) sliderValue++;
                              }),
                                ),
                              ],
                  ),
                ],
              ),
            ),
                ),
                const SizedBox(height: 20),

                // Weight and Age Row
                FadeInDown(
                  delay: const Duration(milliseconds: 600),
                  duration: const Duration(milliseconds: 800),
              child: Row(
                children: [
                  Expanded(
                        child: _buildInputCard(
                          title: 'Weight',
                          value: weight,
                          unit: 'kg',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildControlButton(
                                icon: FontAwesomeIcons.minus,
                                onTap: () => setState(() {
                                  if (weight > 0) weight--;
                                }),
                              ),
                              const SizedBox(width: 20),
                              _buildControlButton(
                                icon: FontAwesomeIcons.plus,
                                onTap: () => setState(() => weight++),
                              ),
                            ],
                          ),
                          ),
                        ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildInputCard(
                          title: 'Age',
                          value: Age,
                          unit: 'years',
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              _buildControlButton(
                                icon: FontAwesomeIcons.minus,
                                onTap: () => setState(() {
                                  if (Age > 0) Age--;
                                }),
                              ),
                              const SizedBox(width: 20),
                              _buildControlButton(
                                icon: FontAwesomeIcons.plus,
                                onTap: () => setState(() => Age++),
                              ),
                            ],
                                    ),
                                  ),
                                ),
                              ],
                  ),
                  ),
                const SizedBox(height: 30),

                // Calculate Button
                FadeInUp(
                  delay: const Duration(milliseconds: 800),
                  duration: const Duration(milliseconds: 800),
                  child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultPage(
                            height: sliderValue,
                            weight: weight,
                            age: Age,
                          ),
                        ),
                );
              },
              child: Container(
                width: double.infinity,
                      height: 60,
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
                      child: const Center(
                  child: Text(
                          'CALCULATE BMI',
                    style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                      fontWeight: FontWeight.bold,
                          ),
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
  }

  Widget _buildGenderCard({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.cardColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppColors.primaryColor,
              size: 40,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textSecondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard({
    required String title,
    required int value,
    required String unit,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.textSecondaryColor,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$value',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              color: AppColors.textSecondaryColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: AppColors.primaryColor,
          size: 20,
        ),
      ),
    );
  }
}

class ResultPage extends StatefulWidget {
  final int height;
  final int weight;
  final int age;
  
  const ResultPage({
    super.key,
    required this.height,
    required this.weight,
    required this.age,
  });

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late double bmires;
  late String bmiCategory;
  late Color bmiColor;

  @override
  void initState() {
    super.initState();
    Logic l = Logic();
    bmires = l.calculateBMI(widget.height, widget.weight);
    _setBMICategory();
  }

  void _setBMICategory() {
    if (bmires < 18.5) {
      bmiCategory = "Underweight";
      bmiColor = Colors.orange;
    } else if (bmires < 25) {
      bmiCategory = "Normal";
      bmiColor = Colors.green;
    } else if (bmires < 30) {
      bmiCategory = "Overweight";
      bmiColor = Colors.orange;
    } else {
      bmiCategory = "Obese";
      bmiColor = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "BMI Result",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    "Your BMI Result",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                FadeInDown(
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 800),
        child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
          child: Column(
            children: [
              Text(
                          bmires.toStringAsFixed(1),
                style: TextStyle(
                            fontSize: 60,
                    fontWeight: FontWeight.bold,
                            color: bmiColor,
              ),
              ),
                        const SizedBox(height: 10),
              Text(
                          bmiCategory,
                style: TextStyle(
                            fontSize: 24,
                            color: bmiColor,
                    fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                FadeInDown(
                  delay: const Duration(milliseconds: 400),
                  duration: const Duration(milliseconds: 800),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Column(
                      children: [
                        _buildResultRow("Height", "${widget.height} cm"),
                        const SizedBox(height: 15),
                        _buildResultRow("Weight", "${widget.weight} kg"),
                        const SizedBox(height: 15),
                        _buildResultRow("Age", "${widget.age} years"),
                        const SizedBox(height: 15),
                        _buildResultRow("BMI", bmires.toStringAsFixed(1)),
                      ],
                    ),
                  ),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondaryColor,
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

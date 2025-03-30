import 'package:food_dairy_app/widget/theme/app_colors.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final mainTheme = FlexThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      bodyLarge: const TextStyle(
        color: AppColors.textColor,
        height: 1.4,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 15,
        color: AppColors.textColor,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        color: AppColors.textSecondaryColor,
      ),
      headlineMedium: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.textColor,
      ),
      titleMedium: const TextStyle(
        color: AppColors.textColor,
        height: 1.4,
        fontSize: 17,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.textColor,
      ),
      displaySmall: const TextStyle(
        fontSize: 36,
        color: AppColors.textColor,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        color: AppColors.secondaryColor,
        fontWeight: FontWeight.w600,
      ),
      labelLarge: TextStyle(
        fontSize: 12,
        color: AppColors.textSecondaryColor,
        fontWeight: FontWeight.w400,
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.cardColor,
      elevation: 0,
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      hintStyle: TextStyle(color: AppColors.textSecondaryColor),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.textColor,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
);

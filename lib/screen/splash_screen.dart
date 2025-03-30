import 'package:flutter/material.dart';
import 'package:food_dairy_app/screen/walkthrough_screen.dart';
import 'package:food_dairy_app/widget/theme/app_colors.dart';
import 'package:animate_do/animate_do.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to walkthrough screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WalkthroughScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Animation
            FadeInDown(
              duration: const Duration(milliseconds: 1500),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor.withOpacity(0.1),
                ),
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor.withOpacity(0.2),
                    ),
                    child: Center(
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor.withOpacity(0.3),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.restaurant_menu,
                            size: 40,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // App Name Animation
            FadeInUp(
              delay: const Duration(milliseconds: 1000),
              duration: const Duration(milliseconds: 1500),
              child: Text(
                "Food Diary",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            
            // Tagline Animation
            FadeInUp(
              delay: const Duration(milliseconds: 1500),
              duration: const Duration(milliseconds: 1500),
              child: Text(
                "Track your daily meals",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondaryColor,
                ),
              ),
            ),
            const SizedBox(height: 50),
            
            // Loading Indicator
            FadeInUp(
              delay: const Duration(milliseconds: 2000),
              duration: const Duration(milliseconds: 1500),
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
import 'package:flutter/material.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/features/onboarding/presentation/screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UpToDo',
      theme: ThemeData(
        fontFamily: 'Lato',
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          surfaceTintColor:
              Colors.transparent, // Prevents Material 3 tonal elevation tint
        ),
      ),
      home: OnboardingScreen(),
    );
  }
}

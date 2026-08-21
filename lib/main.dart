import 'package:flutter/material.dart';
import 'package:uptodo/features/intro/onboarding_screen.dart';

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
      theme: ThemeData(fontFamily: 'Lato',),
      home: OnboardingScreen(),
    );
  }
}

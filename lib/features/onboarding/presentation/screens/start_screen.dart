import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Welcome to UpTodo',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                30.heightBox,
                Text(
                  textAlign: TextAlign.center,
                  'Please login to your account or create new account to continue',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UpToDoButton(
                  text: 'LOGIN',
                  textColour: AppColors.white,
                  backgroundColour: AppColors.purple,
                  onPressed: () {
                    context.go('/signin');
                  },
                ),
                15.heightBox,
                UpToDoButton(
                  text: 'CREATE ACCOUNT',
                  textColour: Colors.white,
                  backgroundColour: Color(0xff121212),
                  onPressed: () {
                    context.go('/signup');
                  },
                  border: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

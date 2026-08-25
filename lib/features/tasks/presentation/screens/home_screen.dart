import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          50.heightBox,
          SvgPicture.asset('assets/images/index.svg', height: 227),
          Text(
            'What do you want to do today?',
            style: TextStyle(fontSize: 20, color: AppColors.white),
          ),
          16.heightBox,
          Text(
            'Tap + to add your tasks',
            style: TextStyle(fontSize: 16, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}

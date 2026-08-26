import 'package:flutter/material.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';

class TaskFilter extends StatelessWidget {
  const TaskFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.popUpBackgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Today',
            style: TextStyle(letterSpacing: -0.32, fontSize: 12, color: AppColors.white,),
          ),
          10.widthBox,
          Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.white,
            size: 16,
          ),
        ],
      ),
    );
  }
}


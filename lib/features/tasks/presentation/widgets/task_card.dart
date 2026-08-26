import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.popUpBackgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Center(
            child: Icon(
              Icons.circle_outlined,
              color: AppColors.white,
              size: 16,
            ),
          ),
          12.widthBox,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Do Math Homework',
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: -0.32,
                    color: AppColors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                4.heightBox,
                Text(
                  'Today At 16:45',
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: -0.32,
                    color: AppColors.mediumLightGray,
                  ),
                ),
              ],
            ),
          ),
          12.widthBox,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.purple,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.school_outlined,
                      size: 14,
                      color: Color(0xff0055a3),
                    ),
                    5.widthBox,
                    Text(
                      'University',
                      style: TextStyle(
                        color: AppColors.white,
                        letterSpacing: -0.32,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              8.widthBox,
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: AppColors.purple,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/flag.svg',
                      width: 14,
                      height: 14,
                    ),
                    Text(
                      '1',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        letterSpacing: -0.32,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

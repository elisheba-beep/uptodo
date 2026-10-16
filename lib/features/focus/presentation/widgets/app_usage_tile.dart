import 'package:flutter/material.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/features/focus/data/models/app_usage.dart';

class AppUsageTile extends StatelessWidget {
  const AppUsageTile({super.key, required this.app});
  final AppUsage app;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.mediumDarkGray,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: app.color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(app.icon, size: 18, color: Colors.white),
          ),
          12.widthBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  app.name,
                  style: TextStyle(fontSize: 14, color: AppColors.white),
                ),
                Text(
                  app.usage,
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ),
          Container(width: 1, height: 32, color: Colors.white24),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.info_outline,
              size: 20,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

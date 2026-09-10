import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptodo/core/providers/task_search/task_search_provider.dart';

class TaskSearchBar extends ConsumerWidget {
  const TaskSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.eerieBlack,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/search-normal.svg'),
          12.widthBox,
          Expanded(
            child: TextField(
              cursorColor: AppColors.mediumLightGray,

              style: TextStyle(color: AppColors.mediumLightGray, fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Search for your task...',
                hintStyle: TextStyle(
                  color: AppColors.mediumLightGray,
                  fontSize: 16,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
              onChanged: (String? newSearchTerm) {
                if (newSearchTerm != null) {
                  ref
                      .read(taskSearchProvider.notifier)
                      .setSearchTerm(newSearchTerm);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

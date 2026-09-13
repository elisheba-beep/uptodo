import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptodo/core/utils/debounce.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_search/task_search_provider.dart';

class TaskSearchBar extends ConsumerStatefulWidget {
  const TaskSearchBar({super.key});

  @override
  ConsumerState<TaskSearchBar> createState() => _TaskSearchBarState();
}

class _TaskSearchBarState extends ConsumerState<TaskSearchBar> {
  final debounce = Debounce(milliseconds: 1000);

  @override
  void dispose() {
    debounce.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  debounce.run(() {
                    ref
                        .read(taskSearchProvider.notifier)
                        .setSearchTerm(newSearchTerm);
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

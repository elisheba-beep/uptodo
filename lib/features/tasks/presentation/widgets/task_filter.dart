import 'package:flutter/material.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/features/tasks/domain/models/task_model.dart';

class TaskFilter extends StatelessWidget {
  const TaskFilter({
    super.key,
    required this.filterValue,
    this.count,
    this.isCollapsible = false,
    this.isExpanded = true,
    this.onTap,
  });

  final Filter filterValue;
  final int? count;
  final bool isCollapsible;
  final bool isExpanded;
  final VoidCallback? onTap;

  String get _displayName {
    final name = filterValue.name;
    if (name.isEmpty) return '';
    return '${name[0].toUpperCase()}${name.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.popUpBackgroundColor,
          borderRadius: BorderRadius.circular(6),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              count != null ? '$_displayName ($count)' : _displayName,
              style: TextStyle(
                letterSpacing: -0.32,
                fontSize: 12,
                color: AppColors.white,
              ),
            ),
            8.widthBox,
            Icon(
              isCollapsible
                  ? (isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down)
                  : Icons.keyboard_arrow_down,
              color: AppColors.white,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

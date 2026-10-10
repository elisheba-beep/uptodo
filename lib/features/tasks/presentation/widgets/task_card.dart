import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/navigation.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/providers/task_card/task_card_provider.dart';
import 'package:uptodo/core/utils/task_helpers.dart';
import 'package:uptodo/features/categories/data/category_list.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_list/task_list_provider.dart';
import 'package:uptodo/features/tasks/presentation/screens/edit_task_screen.dart';

class TaskCard extends ConsumerWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskCardProvider);
    final dueInfo = TaskHelpers.formatTaskDue(task.updatedAt, task.completed);
    final priorityColor = TaskHelpers.getPriorityColor(task.priority);
    final category = getCategoryByName(task.tag);

    final categoryTextColor =
        category != null && category.categoryColor.computeLuminance() > 0.5
        ? AppColors.eerieBlack
        : AppColors.white;

    return GestureDetector(
      onTap: () {
        context.pushTo(EditTaskScreen(task: task));
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.popUpBackgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Center(
              child: Checkbox(
                value: task.completed,
                shape: const CircleBorder(),
                activeColor: AppColors.purple,
                checkColor: AppColors.white,
                side: BorderSide(
                  color: task.completed
                      ? AppColors.purple
                      : AppColors.mediumLightGray,
                  width: 1.5,
                ),
                onChanged: (bool? checked) {
                  ref.read(taskListProvider.notifier).toggleTask(task.id);
                },
              ),
            ),
            12.widthBox,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: -0.32,
                      color: task.completed
                          ? AppColors.mediumGray
                          : AppColors.white,
                      decoration: task.completed
                          ? TextDecoration.lineThrough
                          : null,
                      decorationColor: AppColors.mediumGray,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.heightBox,
                  Text(
                    dueInfo.text,
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: -0.32,
                      color: dueInfo.isOverdue
                          ? AppColors.red
                          : AppColors.mediumLightGray,
                      fontWeight: dueInfo.isOverdue
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            12.widthBox,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (task.tag.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: category?.categoryColor ?? AppColors.purple,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (category != null)
                          SvgPicture.asset(
                            category.categoryPath,
                            width: 14,
                            height: 14,
                          )
                        else
                          const Icon(
                            Icons.tag,
                            size: 14,
                            color: AppColors.white,
                          ),
                        5.widthBox,
                        Text(
                          task.tag,
                          style: TextStyle(
                            color: categoryTextColor,
                            letterSpacing: -0.32,
                            fontSize: 12,

                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                8.widthBox,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: priorityColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/flag.svg',
                        width: 14,
                        height: 14,
                        colorFilter: ColorFilter.mode(
                          priorityColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      4.widthBox,
                      Text(
                        task.priority.toString(),
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
      ),
    );
  }
}

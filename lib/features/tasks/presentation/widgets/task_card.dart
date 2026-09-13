import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/navigation.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/providers/task_card/task_card_provider.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_list/task_list_provider.dart';
import 'package:uptodo/features/tasks/presentation/screens/edit_task_screen.dart';

class TaskCard extends ConsumerWidget {
  const TaskCard({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskCardProvider);
    final String formattedTime = DateFormat(
      'yyyy-MM-dd HH:mm',
    ).format(task.updatedAt);
    return GestureDetector(
      onTap: (){
        context.pushTo(
                      EditTaskScreen(task:task),
                    );
                  
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
                      color: AppColors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.heightBox,
                  Text(
                    formattedTime,
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
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                        task.tag,
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
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.purple),
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

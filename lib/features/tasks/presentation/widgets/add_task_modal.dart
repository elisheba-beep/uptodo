import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/features/tasks/presentation/widgets/calendar_modal.dart';
import 'package:uptodo/features/tasks/presentation/widgets/task_priority_modal.dart';
import 'package:uptodo/features/tasks/presentation/widgets/task_textfield.dart';

class AddTaskModal extends StatefulWidget {
  const AddTaskModal({super.key});

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  late final TextEditingController taskController;
  late final TextEditingController descriptionController;

  bool taskHasText = false;
  bool descriptionHasText = false;

  @override
  void initState() {
    super.initState();
    taskController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    taskController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: AppColors.popUpBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
            16.heightBox,
            TaskTextfield(
              hasText: taskHasText,
              controller: taskController,
              onChanged: (value) {
                bool hasText = value!.trim().isNotEmpty;
                if (hasText != taskHasText) {
                  setState(() {
                    taskHasText = hasText;
                  });
                }
              },
              hintText: 'Task',
              borderColor: taskHasText
                  ? AppColors.mediumGray
                  : Colors.transparent,
            ),
            TaskTextfield(
              hasText: taskHasText,
              controller: descriptionController,
              onChanged: (value) {
                bool hasText = value!.trim().isNotEmpty;
                if (hasText != descriptionHasText) {
                  setState(() {
                    descriptionHasText = hasText;
                  });
                }
              },
              hintText: 'Description',
              borderColor: descriptionHasText
                  ? AppColors.mediumGray
                  : Colors.transparent,
            ),
            35.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) => CalendarModal(),
                          );
                        },
                        icon: SvgPicture.asset('assets/icons/timer.svg'),
                      ),
                      16.widthBox,
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset('assets/icons/tag.svg'),
                      ),
                      16.widthBox,
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) => TaskPriorityModal(),
                          );
                        },

                        icon: SvgPicture.asset('assets/icons/flag.svg'),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/send.svg'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

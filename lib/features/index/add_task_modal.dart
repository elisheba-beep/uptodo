import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptodo/features/constant/app_colors.dart';
import 'package:uptodo/features/constant/size_boxes.dart';
import 'package:uptodo/features/index/task_textfield.dart';

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
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            16.heightBox,
            TaskTextfield(
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
              borderColor: taskHasText ? Color(0xff979797) : Colors.transparent,
            ),
            TaskTextfield(
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
                  ? Color(0xff979797)
                  : Colors.transparent,
            ),
            35.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset('assets/icons/timer.svg'),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset('assets/icons/tag.svg'),
                      ),
                      IconButton(
                        onPressed: () {},
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

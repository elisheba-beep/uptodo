import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/features/categories/presentation/widgets/choose_category_modal.dart';
import 'package:uptodo/features/tasks/presentation/widgets/add_task_modal.dart';
import 'package:uptodo/features/tasks/presentation/widgets/calendar_modal.dart';
import 'package:uptodo/features/tasks/presentation/widgets/task_priority_modal.dart';

class ChooseTimeModal extends StatefulWidget {
  const ChooseTimeModal({super.key});

  @override
  State<ChooseTimeModal> createState() => _ChooseTimeModalState();
}

class _ChooseTimeModalState extends State<ChooseTimeModal> {
  DateTime _selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: AppColors.popUpBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose Time',
              style: TextStyle(color: AppColors.white, fontSize: 16),
            ),
            Divider(thickness: 1, color: AppColors.mediumGray),
            21.heightBox,
            TimePickerSpinner(
              is24HourMode: false,
              normalTextStyle: TextStyle(
                fontSize: 16,
                color: AppColors.white.withValues(alpha: 0.1),
                fontWeight: FontWeight.w600,
              ),
              highlightedTextStyle: TextStyle(
                fontSize: 24,
                color: AppColors.white,
              ),
              spacing: 1,
              itemHeight: 30,
              isForce2Digits: true,
              onTimeChange: (time) {
                setState(() {
                  _selectedTime = time;
                });
              },
            ),
            21.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UpToDoButton(
                  text: 'Cancel',
                  textColour: AppColors.purple,
                  backgroundColour: AppColors.popUpBackgroundColor,
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => CalendarModal(),
                    );
                  },
                ),
                UpToDoButton(
                  text: 'Save',
                  textColour: AppColors.white,
                  backgroundColour: AppColors.purple,
                  onPressed: () {
                    Navigator.pop(context);
                           showDialog(
                            context: context,
                            builder: (context) => TaskPriorityModal(),
                          );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

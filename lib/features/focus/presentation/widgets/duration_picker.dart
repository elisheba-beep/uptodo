import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/features/focus/presentation/providers/focus_notifier.dart';

Future<void> showDurationPicker(BuildContext context, WidgetRef ref) {
  final current = ref.read(focusProvider).duration;
  var minutes = current.inMinutes.clamp(1, 180).toDouble();

  return showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.popUpBackgroundColor,
    builder: (sheetContext) {
      return StatefulBuilder(
        builder: (context, setSheetState) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Focus duration',
                    style: TextStyle(fontSize: 18, color: AppColors.white),
                  ),
                  16.heightBox,
                  Text(
                    '${minutes.round()} min',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                  Slider(
                    value: minutes,
                    min: 1,
                    max: 180,
                    divisions: 179,
                    activeColor: AppColors.purple,
                    onChanged: (v) => setSheetState(() => minutes = v),
                  ),
                  16.heightBox,
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.purple,
                      ),
                      onPressed: () {
                        ref
                            .read(focusProvider.notifier)
                            .selectDuration(Duration(minutes: minutes.round()));
                        Navigator.pop(sheetContext);
                      },
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/features/focus/data/mock_data/mock_app_usage.dart';
import 'package:uptodo/features/focus/presentation/providers/dnd_service.dart';
import 'package:uptodo/features/focus/presentation/providers/focus_notifier.dart';
import 'package:uptodo/features/focus/presentation/providers/focus_session.dart';
import 'package:uptodo/features/focus/presentation/widgets/app_usage_tile.dart';
import 'package:uptodo/features/focus/presentation/widgets/dnd_prompt.dart';
import 'package:uptodo/features/focus/presentation/widgets/duration_picker.dart';
import 'package:uptodo/features/focus/presentation/widgets/focus_ring.dart';
import 'package:uptodo/features/focus/presentation/widgets/weekly_focus_chart.dart';

class FocusModeScreen extends ConsumerWidget {
  const FocusModeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(focusProvider);
    final isRunning = session.status == FocusStatus.running;
    final dndSupported = ref.read(dndServiceProvider).isSupported;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            32.heightBox,
            Center(
              child: FocusRing(
                onTapTime: () => showDurationPicker(context, ref),
              ),
            ),
            20.heightBox,
            Text(
              dndSupported
                  ? 'While your focus mode is on, all of your\n notifications will be off'
                  : 'Stay off your phone until\n the timer ends',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
              ),
            ),
            20.heightBox,
            UpToDoButton(
              text: isRunning ? 'Stop Focusing' : 'Start Focusing',
              textColour: AppColors.white,
              backgroundColour: AppColors.purple,
              onPressed: () async {
                final notifier = ref.read(focusProvider.notifier);
                if (isRunning) {
                  notifier.stop();
                  return;
                }
                final proceed = await prepareDnd(context, ref);
                if (proceed && context.mounted) notifier.start();
              },
            ),
            49.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Overview',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -.5,
                    color: AppColors.white,
                  ),
                ),
                InkWell(
                  onTap: () {},
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
                          'This Week',
                          style: TextStyle(
                            letterSpacing: -0.32,
                            fontSize: 12,
                            color: AppColors.white,
                          ),
                        ),
                        8.widthBox,
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            30.heightBox,
            WeeklyFocusChart(hours: [2, 3, 5, 3, 5, 3, 4, 4, 2], todayIndex: 4),
            30.heightBox,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Applications',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -.5,
                  color: AppColors.white,
                ),
              ),
            ),
            16.heightBox,
            for (final app in mockApps) AppUsageTile(app: app),
          ],
        ),
      ),
    );
  }
}

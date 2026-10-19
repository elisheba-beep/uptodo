import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/features/focus/data/mock_data/mock_app_usage.dart';
import 'package:uptodo/features/focus/presentation/widgets/app_usage_tile.dart';
import 'package:uptodo/features/focus/presentation/widgets/weekly_focus_chart.dart';

class FocusModeScreen extends ConsumerStatefulWidget {
  const FocusModeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FocusModeScreenState();
}

class _FocusModeScreenState extends ConsumerState<FocusModeScreen>
    with SingleTickerProviderStateMixin {
  final durationInSeconds = 45 * 60;
  late AnimationController controller;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(
          vsync: this,
          duration: Duration(seconds: durationInSeconds),
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            controller.reset();
            setState(() => isRunning = false);
          }
        });
  }

  void _toggleFocus() {
    if (isRunning) {
      setState(() {
        controller.reset();
        isRunning = false;
      });
    } else {
      setState(() {
        controller.forward();
        isRunning = true;
      });
    }
  }

  String _formatTime(int totalSeconds) {
    final m = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            32.heightBox,
            Center(
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  final remaining = isRunning
                      ? (durationInSeconds * (1 - controller.value)).ceil()
                      : 0;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 213,
                        height: 213,
                        child: CircularProgressIndicator(
                          value: isRunning ? 1.0 - controller.value : 0,
                          backgroundColor: AppColors.mediumDarkGray,
                          strokeWidth: 20,
                          valueColor: AlwaysStoppedAnimation(AppColors.purple),
                        ),
                      ),
                      Text(
                        _formatTime(remaining),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 40,
                          color: AppColors.white,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            20.heightBox,
            Text(
              textAlign: TextAlign.center,
              'While your focus mode is on, all of your\n notifications will be off',
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
              onPressed: _toggleFocus,
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

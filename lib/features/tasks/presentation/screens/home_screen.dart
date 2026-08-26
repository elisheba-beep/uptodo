import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/features/tasks/presentation/widgets/task_card.dart';
import 'package:uptodo/features/tasks/presentation/widgets/task_filter.dart';
import 'package:uptodo/features/tasks/presentation/widgets/task_search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.hasTask = false});

  final bool hasTask;

  @override
  Widget build(BuildContext context) {
    return hasTask
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TaskSearchBar(),
                  20.heightBox,
                  TaskFilter(),
                  16.heightBox,
                  TaskCard(),
                  16.heightBox,
                  TaskCard(),
                  16.heightBox,
                  TaskCard(),
                  20.heightBox,
                  TaskFilter(),
                  16.heightBox,
                  TaskCard(),
                ],
              ),
            ),
          )
        : Center(
            child: Column(
              children: [
                50.heightBox,
                SvgPicture.asset('assets/images/index.svg', height: 227),
                Text(
                  'What do you want to do today?',
                  style: TextStyle(fontSize: 20, color: AppColors.white),
                ),
                16.heightBox,
                Text(
                  'Tap + to add your tasks',
                  style: TextStyle(fontSize: 16, color: AppColors.white),
                ),
              ],
            ),
          );
  }
}

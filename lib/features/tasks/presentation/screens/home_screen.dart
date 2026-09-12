import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/models/task_model.dart';
import 'package:uptodo/core/providers/task_list/task_list_provider.dart';
import 'package:uptodo/core/providers/task_list/task_list_state.dart';
import 'package:uptodo/features/tasks/presentation/widgets/show_tasks.dart';
import 'package:uptodo/features/tasks/presentation/widgets/task_filter.dart';
import 'package:uptodo/features/tasks/presentation/widgets/task_search_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskListState = ref.watch(taskListProvider);

    return GlobalLoaderOverlay(
      overlayWidgetBuilder: (_) {
        return const Center(child: SpinKitFadingCircle(color: Colors.grey));
      },
      child: Consumer(
        builder: (innerContext, innerRef, child) {
          innerRef.listen<TaskListState>(taskListProvider, (previous, next) {
            if (next.status == TaskListStatus.loading) {
              innerContext.loaderOverlay.show();
            } else {
              innerContext.loaderOverlay.hide();
            }
          });

          return taskListState.tasks.isNotEmpty
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TaskSearchBar(),
                        20.heightBox,
                        TaskFilter(filterValue: Filter.all),
                        16.heightBox,
                        ShowTasks(filter: Filter.all),
                        16.heightBox,
                        TaskFilter(filterValue: Filter.completed),
                        16.heightBox,
                        ShowTasks(filter: Filter.completed),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/index.svg', height: 227),
                      16.heightBox,
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
        },
      ),
    );
  }
}

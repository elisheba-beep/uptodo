import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/features/tasks/domain/models/task_model.dart';
import 'package:uptodo/features/tasks/presentation/providers/filtered_tasks/filtered_tasks_provider.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_list/task_list_provider.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_list/task_list_state.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_search/task_search_provider.dart';
import 'package:uptodo/features/tasks/presentation/widgets/show_tasks.dart';
import 'package:uptodo/features/tasks/presentation/widgets/task_filter.dart';
import 'package:uptodo/features/tasks/presentation/widgets/task_search_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isCompletedExpanded = true;



  @override
  Widget build(BuildContext context) {
    final taskListState = ref.watch(taskListProvider);
    final activeTasks = ref.watch(filteredTasksProvider(Filter.active));
    final completedTasks = ref.watch(filteredTasksProvider(Filter.completed));
    final searchTerm = ref.watch(taskSearchProvider);
    

    return GlobalLoaderOverlay(
      overlayWidgetBuilder: (_) {
        return const Center(child: SpinKitFadingCircle(color: Colors.grey));
      },
      child: Consumer(
        builder: (innerContext, innerRef, child) {
          innerRef.listen<TaskListState>(taskListProvider, (previous, next) {
            if (next.status == TaskListStatus.loading && next.tasks.isEmpty) {
              innerContext.loaderOverlay.show();
            } else {
              innerContext.loaderOverlay.hide();
            }
          });

          if (taskListState.tasks.isEmpty &&
              taskListState.status != TaskListStatus.loading) {
            return Center(
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
          }

          final bool isSearching = searchTerm.trim().isNotEmpty;
          final bool hasNoSearchResults =
              isSearching && activeTasks.isEmpty && completedTasks.isEmpty;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TaskSearchBar(),
                  20.heightBox,
                  if (hasNoSearchResults) ...[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 48),
                        child: Text(
                          'No tasks found for "$searchTerm"',
                          style: const TextStyle(
                            color: AppColors.mediumLightGray,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ] else
                    TaskFilter(
                      filterValue: Filter.active,
                      count: activeTasks.length,
                    ),
                  16.heightBox,
                  if (activeTasks.isNotEmpty) ...[
                    const ShowTasks(filter: Filter.active),
                  ] else if (completedTasks.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      child: const Text(
                        'No active tasks, you are caught up!',
                        style: TextStyle(
                          color: AppColors.mediumLightGray,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                  if (completedTasks.isNotEmpty) ...[
                    24.heightBox,
                    TaskFilter(
                      filterValue: Filter.completed,
                      count: completedTasks.length,
                      isCollapsible: true,
                      isExpanded: _isCompletedExpanded,
                      onTap: () {
                        setState(() {
                          _isCompletedExpanded = !_isCompletedExpanded;
                        });
                      },
                    ),
                    if (_isCompletedExpanded) ...[
                      16.heightBox,
                      ShowTasks(filter: Filter.completed),
                    ],
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

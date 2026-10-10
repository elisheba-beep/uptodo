import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/features/tasks/domain/models/task_model.dart';
import 'package:uptodo/core/providers/task_card/task_card_provider.dart';
import 'package:uptodo/features/tasks/presentation/providers/filtered_tasks/filtered_tasks_provider.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_list/task_list_provider.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_list/task_list_state.dart';
import 'package:uptodo/features/tasks/presentation/widgets/task_card.dart';

class ShowTasks extends ConsumerStatefulWidget {
  const ShowTasks({super.key, required this.filter});
  final Filter filter;

  @override
  ConsumerState<ShowTasks> createState() => _ShowTasksState();
}

class _ShowTasksState extends ConsumerState<ShowTasks> {
  @override
  Widget build(BuildContext context) {
    ref.listen<TaskListState>(taskListProvider, (previous, next) {
      if (next.status == TaskListStatus.failure) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error', textAlign: TextAlign.center),
              content: Text(next.error, textAlign: TextAlign.center),
            );
          },
        );
      }
    });

    final taskListState = ref.watch(taskListProvider);
    final filteredTasks = ref.watch(filteredTasksProvider(widget.filter));

    if (taskListState.status == TaskListStatus.failure &&
        filteredTasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(taskListState.error, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                ref.read(taskListProvider.notifier).getTasks();
              },
              child: Text('Please Retry!', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      );
    }

    if (filteredTasks.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filteredTasks.length,
      separatorBuilder: (BuildContext context, int index) {
        return 16.heightBox;
      },
      itemBuilder: (BuildContext context, int index) {
        final task = filteredTasks[index];
        return ProviderScope(
          overrides: [taskCardProvider.overrideWithValue(task)],
          child: TaskCard(),
        );
      },
    );
  }
}

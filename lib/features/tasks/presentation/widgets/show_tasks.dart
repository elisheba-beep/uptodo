import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptodo/core/constant/navigation.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/models/task_model.dart';
import 'package:uptodo/core/providers/filtered_tasks/filtered_tasks_provider.dart';
import 'package:uptodo/core/providers/task_draft/task_draft_provider.dart';
import 'package:uptodo/features/tasks/presentation/screens/edit_task_screen.dart';
import 'package:uptodo/features/tasks/presentation/widgets/task_card.dart';

class ShowTasks extends ConsumerWidget {
  const ShowTasks({super.key, required this.filter});
  final Filter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredTasks = ref.watch(filteredTasksProvider(filter));
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filteredTasks.length,
      separatorBuilder: (BuildContext context, int index) {
        return 16.heightBox;
      },
      itemBuilder: (BuildContext context, int index) {
        final task = filteredTasks[index];
        return TaskCard(
          task: task,
          onTap: () {
            print('tapped');
            ref.read(taskDraftProvider.notifier).startUpdatingTask(task.id);
            context.pushTo(EditTaskScreen());
          },
        );
      },
    );
  }
}

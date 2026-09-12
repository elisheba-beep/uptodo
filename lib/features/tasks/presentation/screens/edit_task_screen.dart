import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/models/task_model.dart';
import 'package:uptodo/core/providers/task_draft/task_draft_provider.dart';
import 'package:uptodo/core/providers/task_list/task_list_provider.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/features/tasks/presentation/widgets/add_task_modal.dart';

class EditTaskScreen extends ConsumerStatefulWidget {
  const EditTaskScreen({super.key, required this.task});
  final Task task;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends ConsumerState<EditTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final currentTask = ref
        .watch(taskListProvider)
        .tasks
        .firstWhere((task) => task.id == widget.task.id, orElse: () => widget.task);

    final String formattedTime = DateFormat(
      'yyyy-MM-dd HH:mm',
    ).format(currentTask.updatedAt);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, color: AppColors.white, size: 32),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.repeat, color: AppColors.white, size: 32),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 24),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            ListTile(
              tileColor: Colors.transparent,
              leading: Checkbox(
                activeColor: AppColors.white,
                value: currentTask.completed,
                shape: const CircleBorder(),
                onChanged: (bool? checked) {
                  ref
                      .read(taskListProvider.notifier)
                      .toggleTask(currentTask.id);
                },
              ),
              title: Text(
                currentTask.title,
                style: TextStyle(color: AppColors.white),
              ),
              subtitle: currentTask.desc != null && currentTask.desc!.isNotEmpty
                  ? Text(
                      currentTask.desc!,
                      style: TextStyle(
                        color: AppColors.mediumGray,
                        fontSize: 14,
                      ),
                    )
                  : null,
              trailing: IconButton(
                onPressed: () {
                  ref
                      .read(taskDraftProvider.notifier)
                      .startUpdatingTask(currentTask.id);
                  showDialog(
                    context: context,
                    builder: (context) => AddTaskModal(task: currentTask),
                  );
                },
                icon: Icon(Icons.edit),
              ),
            ),
            12.heightBox,
            EditTile(
              editKey: 'Task Time:',
              icon: Icons.alarm,
              value: formattedTime,
            ),
            EditTile(
              editKey: 'Task Category:',
              icon: Icons.tag,
              value: currentTask.tag.isEmpty ? 'None' : currentTask.tag,
            ),
            EditTile(
              editKey: 'Task Priority:',
              icon: Icons.flag,
              value: 'Priority ${currentTask.priority}',
            ),
            EditTile(
              editKey: 'Sub-Task:',
              icon: Icons.more,
              value: 'Add Sub-Task',
            ),
            GestureDetector(
              onTap: () async {
                final removeOrNot = await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Are you sure?'),
                      content: const Text('Do you really want to delete?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
                if (removeOrNot) {
                  ref
                      .read(taskListProvider.notifier)
                      .deleteTask(currentTask.id);
                  if (context.mounted) Navigator.pop(context);
                }
              },
              child: ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Delete Task', style: TextStyle(color: Colors.red)),
              ),
            ),
            Spacer(),
            UpToDoButton(
              text: 'Edit Task',
              textColour: AppColors.white,
              backgroundColour: AppColors.purple,
              onPressed: () {
                ref
                    .read(taskDraftProvider.notifier)
                    .startUpdatingTask(currentTask.id);

                showDialog(
                  context: context,
                  builder: (context) => AddTaskModal(task: currentTask),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EditTile extends StatelessWidget {
  const EditTile({
    super.key,
    required this.editKey,
    required this.value,
    required this.icon,
  });

  final String editKey;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(editKey, style: TextStyle(color: AppColors.white)),
        trailing: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.popUpBackgroundColor,
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              letterSpacing: -0.32,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

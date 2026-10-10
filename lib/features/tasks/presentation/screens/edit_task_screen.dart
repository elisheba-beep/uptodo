import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/utils/task_helpers.dart';
import 'package:uptodo/features/categories/presentation/widgets/choose_category_modal.dart';
import 'package:uptodo/features/tasks/domain/models/task_model.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_draft/task_draft_provider.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_list/task_list_provider.dart';
import 'package:uptodo/features/tasks/presentation/widgets/add_task_modal.dart';
import 'package:uptodo/features/tasks/presentation/widgets/calendar_modal.dart';
import 'package:uptodo/features/tasks/presentation/widgets/choose_time_modal.dart';
import 'package:uptodo/features/tasks/presentation/widgets/task_priority_modal.dart';

class EditTaskScreen extends ConsumerStatefulWidget {
  const EditTaskScreen({super.key, required this.task});
  final Task task;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends ConsumerState<EditTaskScreen> {
  void showEditTitleDialog(Task currentTask) {
    final titleController = TextEditingController(text: currentTask.title);
    final descController = TextEditingController(text: currentTask.desc ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.popUpBackgroundColor,
        title: const Text(
          'Edit Task',
          style: TextStyle(color: AppColors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(color: AppColors.white),
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            12.heightBox,
            TextField(
              controller: descController,
              style: const TextStyle(color: AppColors.white),
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.purple),
            ),
          ),
          TextButton(
            onPressed: () {
              final newTitle = titleController.text.trim();
              if (newTitle.isNotEmpty) {
                ref
                    .read(taskListProvider.notifier)
                    .editTask(
                      currentTask.id,
                      newTitle,
                      descController.text.trim().isEmpty
                          ? null
                          : descController.text.trim(),
                      currentTask.updatedAt,
                      currentTask.tag,
                      currentTask.priority,
                    );
              }
              Navigator.pop(context);
            },
            child: const Text('Save', style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentTask = ref
        .watch(taskListProvider)
        .tasks
        .firstWhere(
          (task) => task.id == widget.task.id,
          orElse: () => widget.task,
        );
    final dueInfo = TaskHelpers.formatTaskDue(
      currentTask.updatedAt,
      currentTask.completed,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, color: AppColors.white, size: 28),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.repeat, color: AppColors.white, size: 32),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 24),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              tileColor: Colors.transparent,
              leading: Checkbox(
                activeColor: AppColors.purple,
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
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  decoration: currentTask.completed
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              subtitle: (currentTask.desc ?? '').isNotEmpty
                  ? Text(
                      currentTask.desc!,
                      style: TextStyle(
                        color: AppColors.mediumGray,
                        fontSize: 14,
                      ),
                    )
                  : null,
              trailing: IconButton(
                onPressed: () => showEditTitleDialog(currentTask),
                icon: Icon(Icons.edit, color: AppColors.white),
              ),
            ),
            12.heightBox,
            EditTile(
              editKey: 'Task Time:',
              icon: Icons.alarm,
              value: dueInfo.text,
              onTap: () async {
                final selectedDate = await showDialog(
                  context: context,
                  builder: (_)=> CalendarModal(initialDate: currentTask.updatedAt,)
                );
                if(selectedDate == null || !context.mounted) return;

                final selectedTime = await showDialog(
                  context: context,
                  builder:(_)=> ChooseTimeModal(initialTime: currentTask.updatedAt),
                );
                if(selectedTime == null || !context.mounted) return;

                final combinedDateTime = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
                ref
                    .read(taskDraftProvider.notifier)
                    .startUpdatingTask(currentTask.id);
                
                ref
                    .read(taskListProvider.notifier)
                    .editTask(
                      currentTask.id,
                      currentTask.title,
                      currentTask.desc,
                      combinedDateTime,
                      currentTask.tag,
                      currentTask.priority,
                    );
              },
            ),
            EditTile(
              editKey: 'Task Category:',
              icon: Icons.tag,
              value: currentTask.tag.isEmpty ? 'None' : currentTask.tag,
              onTap: () async {
                ref
                    .read(taskDraftProvider.notifier)
                    .startUpdatingTask(currentTask.id);
                await showDialog(
                  context: context,
                  builder: (_) => const ChooseCategoryModal(),
                );
                final newTag = ref.read(taskDraftProvider).tag;
                ref
                    .read(taskListProvider.notifier)
                    .editTask(
                      currentTask.id,
                      currentTask.title,
                      currentTask.desc,
                      currentTask.updatedAt,
                      newTag,
                      currentTask.priority,
                    );
              },
            ),
            EditTile(
              editKey: 'Task Priority:',
              icon: Icons.flag,
              value: 'Priority ${currentTask.priority}',
              onTap: () async {
                ref
                    .read(taskDraftProvider.notifier)
                    .startUpdatingTask(currentTask.id);
                await showDialog(
                  context: context,
                  builder: (_) => const TaskPriorityModal(),
                );
                final newPriority = ref.read(taskDraftProvider).priority;
                ref
                    .read(taskListProvider.notifier)
                    .editTask(
                      currentTask.id,
                      currentTask.title,
                      currentTask.desc,
                      currentTask.updatedAt,
                      currentTask.tag,
                      newPriority,
                    );
              },
            ),
            EditTile(
              editKey: 'Sub-Task:',
              icon: Icons.more,
              value: 'Add Sub-Task',
            ),
            24.heightBox,
            GestureDetector(
              onTap: () async {
                final removeOrNot = await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Delete Task'),
                      content: const Text(
                        'Do you really want to delete this task?',
                      ),
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
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Delete Task', style: TextStyle(color: Colors.red)),
              ),
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
    this.onTap,
  });

  final String editKey;
  final String value;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: onTap,
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

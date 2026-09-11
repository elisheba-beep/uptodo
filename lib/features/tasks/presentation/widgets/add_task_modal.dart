import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/providers/task_draft/task_draft_provider.dart';
import 'package:uptodo/core/providers/task_list/task_list_provider.dart';
import 'package:uptodo/features/tasks/presentation/widgets/calendar_modal.dart';
import 'package:uptodo/features/tasks/presentation/widgets/task_priority_modal.dart';
import 'package:uptodo/features/tasks/presentation/widgets/task_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTaskModal extends ConsumerStatefulWidget {
  const AddTaskModal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends ConsumerState<AddTaskModal> {
  late final TextEditingController taskController;
  late final TextEditingController descriptionController;

  bool taskHasText = false;
  bool descriptionHasText = false;

  @override
  void initState() {
    super.initState();

    taskController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    taskController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(taskDraftProvider);
    final draftNotifier = ref.read(taskDraftProvider.notifier);
    final taskListNotifier = ref.read(taskListProvider.notifier);

    if (taskController.text != draft.title) {
      taskController.text = draft.title;
    }
    if (descriptionController.text != (draft.desc ?? '')) {
      descriptionController.text = draft.desc ?? '';
    }

    bool taskHasText = draft.title.trim().isNotEmpty;
    bool descriptionHasText = (draft.desc ?? '').trim().isNotEmpty;
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: AppColors.popUpBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
            16.heightBox,
            TaskTextfield(
              hasText: taskHasText,
              controller: taskController,
              onChanged: (value) {
                draftNotifier.updateTitle(value ?? '');
              },
              hintText: 'Task',
              borderColor: taskHasText
                  ? AppColors.mediumGray
                  : Colors.transparent,
            ),
            TaskTextfield(
              hasText: descriptionHasText,
              controller: descriptionController,
              onChanged: (value) {
                final text = value ?? '';
                draftNotifier.updateDesc(text.isEmpty ? null : text);
              },
              hintText: 'Description',
              borderColor: descriptionHasText
                  ? AppColors.mediumGray
                  : Colors.transparent,
            ),
            35.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => CalendarModal(),
                          );
                        },

                        icon: SvgPicture.asset('assets/icons/timer.svg'),
                      ),
                      16.widthBox,
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset('assets/icons/tag.svg'),
                      ),
                      16.widthBox,
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) => TaskPriorityModal(),
                          );
                        },

                        icon: SvgPicture.asset('assets/icons/flag.svg'),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: draftNotifier.isValid
                      ? () {
                          if (draft.id.isEmpty) {
                            taskListNotifier.addTask(
                              draft.title,
                              draft.desc,
                              draft.updatedAt,
                              draft.tag,
                              draft.priority,
                            );
                          } else {
                            taskListNotifier.editTask(
                              draft.id,
                              draft.title,
                              draft.desc,
                              draft.updatedAt,
                              draft.tag,
                              draft.priority,
                            );
                          }
                          Navigator.pop(context);

                          draftNotifier.startCreatingTask();
                        }
                      : null,

                  icon: SvgPicture.asset('assets/icons/send.svg'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

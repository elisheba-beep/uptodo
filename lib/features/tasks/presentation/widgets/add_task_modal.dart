import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/utils/task_helpers.dart';
import 'package:uptodo/features/categories/data/category_list.dart';
import 'package:uptodo/features/categories/presentation/widgets/choose_category_modal.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_draft/task_draft_provider.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_list/task_list_provider.dart';
import 'package:uptodo/features/tasks/presentation/widgets/calendar_modal.dart';
import 'package:uptodo/features/tasks/presentation/widgets/choose_time_modal.dart';
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
    final draft = ref.read(taskDraftProvider);
    taskController = TextEditingController(text: draft.title);

    descriptionController = TextEditingController(text: draft.desc ?? '');
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

    bool taskHasText = draft.title.trim().isNotEmpty;
    bool descriptionHasText = (draft.desc ?? '').trim().isNotEmpty;
    final category = getCategoryByName(draft.tag);
    final priorityColor = TaskHelpers.getPriorityColor(draft.priority);

 

    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: AppColors.popUpBackgroundColor,
      ),
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
            hintText: 'Title',
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
          16.heightBox,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(
                backgroundColor: AppColors.nero,
                avatar: const Icon(
                  Icons.timer_outlined,
                  size: 14,
                  color: AppColors.white,
                ),
                label: Text(
                  DateFormat('d MMM HH:mm').format(draft.updatedAt),
                  style: const TextStyle(color: AppColors.white, fontSize: 12),
                ),
              ),
              Chip(
                backgroundColor: AppColors.nero,
                avatar: Icon(Icons.flag, size: 14, color: priorityColor),
                label: Text(
                  'Priority ${draft.priority}',
                  style: TextStyle(color: priorityColor, fontSize: 12),
                ),
              ),
              if (draft.tag.isNotEmpty)
                Chip(
                  backgroundColor: category?.categoryColor ?? AppColors.purple,
                  avatar: category != null
                      ? SvgPicture.asset(
                          category.categoryPath,
                          width: 14,
                          height: 14,
                        )
                      : null,
                  label: Text(
                    draft.tag,
                    style: const TextStyle(
                      color: AppColors.eerieBlack,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              20.heightBox,
              Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          // FocusScope.of(context).unfocus();

                          final selectedDate = await showDialog(
                            context: context,
                            builder: (_) =>
                                CalendarModal(initialDate: draft.updatedAt),
                          );
                          if (selectedDate == null || !context.mounted) return;

                          final selectedTime = await showDialog(
                            context: context,
                            builder: (_) =>
                                ChooseTimeModal(initialTime: draft.updatedAt),
                          );
                          if (selectedTime == null) return;

                          final combinedDateTime = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );

                          ref
                              .read(taskDraftProvider.notifier)
                              .updateDateTime(combinedDateTime);
                        },

                        icon: SvgPicture.asset('assets/icons/timer.svg'),
                      ),
                      12.widthBox,

                      IconButton(
                        onPressed: () {
                          // FocusScope.of(context).unfocus();

                          showDialog(
                            context: context,
                            builder: (context) => TaskPriorityModal(),
                          );
                        },

                        icon: SvgPicture.asset('assets/icons/flag.svg'),
                      ),
                      12.widthBox,

                      IconButton(
                        onPressed: () {
                          // FocusScope.of(context).unfocus();

                          showDialog(
                            context: context,
                            builder: (context) => ChooseCategoryModal(),
                          );
                        },
                        icon: SvgPicture.asset('assets/icons/tag.svg'),
                      ),
                    ],
                  ),

                  IconButton(
                    onPressed: draftNotifier.isValid
                        ? () {
                          // FocusScope.of(context).unfocus();

                            final tag = draft.tag.isEmpty ? 'Work' : draft.tag;
                            taskListNotifier.addTask(
                              draft.title,
                              draft.desc,
                              draft.updatedAt,
                             tag,
                              draft.priority,
                            );
                        
                            Navigator.pop(context);

                            draftNotifier.startCreatingTask();
                          }
                        : null,

                    icon: SvgPicture.asset(
                      'assets/icons/send.svg',
                      colorFilter: ColorFilter.mode(
                        draftNotifier.isValid
                            ? AppColors.purple
                            : AppColors.mediumGray,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

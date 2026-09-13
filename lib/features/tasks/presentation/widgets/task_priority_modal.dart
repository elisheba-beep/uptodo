import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/features/categories/presentation/widgets/choose_category_modal.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_draft/task_draft_provider.dart';
import 'package:uptodo/features/tasks/presentation/widgets/add_task_modal.dart';

class TaskPriorityModal extends ConsumerStatefulWidget {
  const TaskPriorityModal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TaskPriorityModalState();
}

class _TaskPriorityModalState extends ConsumerState<TaskPriorityModal> {
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _selectedIndex = ref.read(taskDraftProvider).priority - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: AppColors.popUpBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Task Priority',
              style: TextStyle(color: AppColors.white, fontSize: 16),
            ),
            Divider(thickness: 1, color: AppColors.mediumGray),
            21.heightBox,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    ref
                        .read(taskDraftProvider.notifier)
                        .updatePriority(_selectedIndex + 1);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedIndex == index
                          ? AppColors.purple
                          : AppColors.nero,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Center(
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/icons/flag.svg'),
                            Text(
                              (index + 1).toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            18.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UpToDoButton(
                  text: 'Cancel',
                  textColour: AppColors.purple,
                  backgroundColour: AppColors.popUpBackgroundColor,
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => AddTaskModal(),
                    );
                  },
                ),
                UpToDoButton(
                  text: 'Save',
                  textColour: AppColors.white,
                  backgroundColour: AppColors.purple,
                  onPressed: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => ChooseCategoryModal(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

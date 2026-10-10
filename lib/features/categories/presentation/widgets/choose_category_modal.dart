import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/navigation.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/features/categories/data/category_list.dart';
import 'package:uptodo/features/categories/presentation/screens/create_new_category_screen.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_draft/task_draft_provider.dart';

class ChooseCategoryModal extends ConsumerWidget {
  const ChooseCategoryModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const submitSnackBar = SnackBar(
      content: Text('you can submit your task now'),
    );
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 19),
      backgroundColor: AppColors.popUpBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose Category',
              style: TextStyle(color: AppColors.white, fontSize: 16),
            ),
            Divider(thickness: 1, color: AppColors.mediumGray),
            21.heightBox,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 32,
                mainAxisSpacing: 16,
                childAspectRatio: .6,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (index == categories.length - 1) {
                          Navigator.pop(context);
                          context.pushTo(const CreateNewCategoryScreen());
                        } else {
                          ref
                              .read(taskDraftProvider.notifier)
                              .updateTag(categories[index].categoryName);
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        height: 64,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: categories[index].categoryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: SvgPicture.asset(categories[index].categoryPath),
                      ),
                    ),
                    5.heightBox,
                    Text(
                      textAlign: TextAlign.center,
                      categories[index].categoryName,
                      style: TextStyle(fontSize: 14, color: AppColors.white),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

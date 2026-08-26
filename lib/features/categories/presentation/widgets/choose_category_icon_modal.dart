import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/navigation.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/features/categories/data/category_list.dart';
import 'package:uptodo/features/categories/presentation/screens/create_new_category_screen.dart';

class ChooseCategoryIconModal extends StatelessWidget {
  const ChooseCategoryIconModal({super.key});

  @override
  Widget build(BuildContext context) {
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
              'Choose Category Icon',
              style: TextStyle(color: AppColors.white, fontSize: 16),
            ),
            Divider(thickness: 1, color: AppColors.mediumGray),
            21.heightBox,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length - 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 18,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        context.pushReplacement(
                          CreateNewCategoryScreen(
                            icon: categories[index].categoryPath,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: SvgPicture.asset(categories[index].categoryPath),
                      ),
                    ),
                    5.heightBox,
                    Text(
                      textAlign: TextAlign.center,
                      categories[index].categoryName,
                      style: TextStyle(fontSize: 12, color: AppColors.white),
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

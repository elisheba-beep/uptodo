import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/features/categories/data/category_list.dart';

class ChooseCategoryIconModal extends StatelessWidget {
  const ChooseCategoryIconModal({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = <String, String>{};
    for (final c in categories.take(categories.length - 1)) {
      icons.putIfAbsent(c.categoryPath, () => c.categoryName);
    }
    final entries = icons.entries.toList();

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
              itemCount: entries.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 18,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context, entries[index].key),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: SvgPicture.asset(entries[index].key),
                      ),
                    ),
                    5.heightBox,
                    Text(
                      entries[index].value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.white,
                      ),
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

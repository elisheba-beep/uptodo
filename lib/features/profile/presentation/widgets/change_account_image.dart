import 'package:flutter/material.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';

enum ImageSourceType { camera, gallery, drive }

class ChangeImageModal extends StatelessWidget {
  const ChangeImageModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        color: AppColors.popUpBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Change account Image',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          12.heightBox,
          const Divider(color: AppColors.mediumGray, thickness: 1),
          8.heightBox,
          _ImageOptionTile(
            title: 'Take picture',
            onTap: () {
              Navigator.pop(context, ImageSourceType.camera);
            },
          ),
          _ImageOptionTile(
            title: 'Import from gallery',
            onTap: () {
              Navigator.pop(context, ImageSourceType.gallery);
            },
          ),
          _ImageOptionTile(
            title: 'Import from Google Drive',
            onTap: () {
              Navigator.pop(context, ImageSourceType.drive);
            },
          ),
          16.heightBox,
        ],
      ),
    );
  }
}

class _ImageOptionTile extends StatelessWidget {
  const _ImageOptionTile({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/app_links.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/utils/open_link.dart';

Future<void> showSupportUsSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => const SupportUsSheet(),
  );
}

class SupportUsSheet extends StatelessWidget {
  const SupportUsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        color: AppColors.popUpBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Support Us',
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
            const Text(
              'If UpToDo helps you stay on top of things, a rating or a '
                  'share means a lot.',
              style: TextStyle(fontSize: 14, color: AppColors.mediumLightGray),
            ),
            8.heightBox,
            _SupportOption(
              icon: Icons.star_outline,
              title: 'Rate UpToDo',
              onTap: () {
                openLink(context, AppLinks.storeListing);
                Navigator.pop(context);
              },
            ),
            _SupportOption(
              icon: Icons.share_outlined,
              title: 'Share with friends',
              onTap: () {
                Navigator.pop(context);
                SharePlus.instance.share(
                  ShareParams(text: AppLinks.shareMessage),
                );
              },
            ),
            8.heightBox,
          ],
        ),
      ),
    );
  }
}

class _SupportOption extends StatelessWidget {
  const _SupportOption({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: AppColors.white, size: 22),
            12.widthBox,
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
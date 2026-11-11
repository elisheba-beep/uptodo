import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/app_links.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/utils/open_link.dart';
import 'package:uptodo/features/profile/presentation/widgets/settings_page_scaffold.dart';
import 'package:uptodo/features/profile/presentation/widgets/settings_tile.dart';

// Cached, so the version is only read from the platform once.
final packageInfoProvider = FutureProvider<PackageInfo>(
      (ref) => PackageInfo.fromPlatform(),
);

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(packageInfoProvider).value;
    final versionText = info == null
        ? ''
        : 'Version ${info.version} (${info.buildNumber})';

    return SettingsPageScaffold(
      title: 'About Us',
      child: Column(
        children: [
          24.heightBox,
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppColors.purple,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.check_rounded,
              size: 52,
              color: AppColors.white,
            ),
          ),
          16.heightBox,
          const Text(
            'UpToDo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
          4.heightBox,
          Text(
            versionText,
            style: const TextStyle(fontSize: 14, color: AppColors.mediumGray),
          ),
          24.heightBox,
          const Text(
            'UpToDo helps you plan your tasks, organise them into '
                'categories and stay focused with a built-in focus timer.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: AppColors.mediumLightGray,
            ),
          ),
          32.heightBox,
          SettingsTile(
            title: 'Open source licenses',
            icon: Icons.description_outlined,
            onTap: () => showLicensePage(
              context: context,
              applicationName: 'UpToDo',
              applicationVersion: info?.version,
            ),
          ),
          SettingsTile(
            title: 'Privacy policy',
            icon: Icons.privacy_tip_outlined,
            onTap: () => openLink(context, AppLinks.privacyPolicy),
          ),
          SettingsTile(
            title: 'Terms of service',
            icon: Icons.gavel_outlined,
            onTap: () => openLink(context, AppLinks.termsOfService),
          ),
        ],
      ),
    );
  }
}
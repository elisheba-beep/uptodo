import 'package:flutter/material.dart';
import 'package:uptodo/core/constant/app_colors.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      dense: true,
      tileColor: Colors.transparent,
      onTap: onTap,
      leading: Icon(icon, size: 24, color: AppColors.white),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
      ),
      trailing: Icon(Icons.chevron_right, size: 24, color: AppColors.white),
    );
  }
}

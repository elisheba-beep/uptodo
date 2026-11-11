import 'package:flutter/material.dart';

class Settings {
  final String title;
  final IconData icon;
  final void Function(BuildContext context) onTap;

  const Settings({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
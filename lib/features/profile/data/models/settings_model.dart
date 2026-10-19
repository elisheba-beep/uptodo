import 'package:flutter/material.dart';


class Settings {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const Settings({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
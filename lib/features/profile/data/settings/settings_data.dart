import 'package:flutter/material.dart';

import 'package:uptodo/features/profile/data/models/settings_model.dart';

final List<Settings> accountSettings = [
  Settings(title: 'Change Account Name', icon: Icons.person, onTap: () {}),
  Settings(title: 'Change Account Password', icon: Icons.key, onTap: () {}),
  Settings(title: 'Change Account Image', icon: Icons.camera, onTap: () {}),
];

final List<Settings> upToDoSettings = [
  Settings(title: 'About Us', icon: Icons.menu, onTap: () {}),
  Settings(title: 'FAQ', icon: Icons.info, onTap: () {}),
  Settings(title: 'Help & Feedback', icon: Icons.flash_on, onTap: () {}),
  Settings(title: 'Support Us', icon: Icons.thumb_up_sharp, onTap: () {}),
];

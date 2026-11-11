import 'package:flutter/material.dart';
import 'package:uptodo/core/constant/navigation.dart';
import 'package:uptodo/features/profile/data/models/settings_model.dart';
import 'package:uptodo/features/profile/presentation/screens/about_screen.dart';
import 'package:uptodo/features/profile/presentation/screens/faq_screen.dart';
import 'package:uptodo/features/profile/presentation/screens/help_feedback_screen.dart';
import 'package:uptodo/features/profile/presentation/widgets/support_us_sheet.dart';

final List<Settings> upToDoSettings = [
  Settings(
    title: 'About Us',
    icon: Icons.menu,
    onTap: (context) => context.pushTo(const AboutScreen()),
  ),
  Settings(
    title: 'FAQ',
    icon: Icons.info,
    onTap: (context) => context.pushTo(const FaqScreen()),
  ),
  Settings(
    title: 'Help & Feedback',
    icon: Icons.flash_on,
    onTap: (context) => context.pushTo(const HelpFeedbackScreen()),
  ),
  Settings(
    title: 'Support Us',
    icon: Icons.thumb_up_sharp,
    onTap: (context) => showSupportUsSheet(context),
  ),
];
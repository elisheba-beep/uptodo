import 'package:flutter/material.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/features/profile/presentation/widgets/settings_page_scaffold.dart';

class _FaqItem {
  const _FaqItem(this.question, this.answer);
  final String question;
  final String answer;
}

const _faqs = [
  _FaqItem(
    'How do I add a task?',
    'Tap the purple + button at the bottom of the screen, type your task, '
        'and choose a time, category and priority if you want to.',
  ),
  _FaqItem(
    'How do I edit or delete a task?',
    'Tap a task to open it. From there you can change its title, time, '
        'category and priority, or delete it.',
  ),
  _FaqItem(
    'How do I mark a task as done?',
    'Tap the circle next to the task. Completed tasks are counted under '
        '"Task Done" on your profile.',
  ),
  _FaqItem(
    'Can I create my own categories?',
    'Yes. When choosing a category for a task, pick "Create New" to make '
        'your own with a name, colour and icon.',
  ),
  _FaqItem(
    'How does Focus Mode work?',
    'Pick how long you want to focus, then tap Start Focusing. The timer '
        'keeps running even if you switch tabs or leave the app, and you get '
        'a notification when the session ends.',
  ),
  _FaqItem(
    'Why does Focus Mode need Do Not Disturb access?',
    'On Android, silencing other apps\' notifications requires this special '
        'permission. Your previous Do Not Disturb setting is restored when the '
        'session ends. You can turn this off in App Settings.',
  ),
  _FaqItem(
    'How do I change my name, password or photo?',
    'Go to Profile and use the options under Account.',
  ),
  _FaqItem(
    'I found a bug or have an idea. What do I do?',
    'Open Help & Feedback from your profile and send us a message. We read '
        'everything.',
  ),
];

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsPageScaffold(
      title: 'FAQ',
      child: Column(
        children: [
          for (final item in _faqs)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _FaqTile(item: item),
            ),
        ],
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.item});
  final _FaqItem item;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        color: AppColors.popUpBackgroundColor,
        child: Theme(
    
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            iconColor: AppColors.white,
            collapsedIconColor: AppColors.white,
            shape: const Border(),
            collapsedShape: const Border(),
            tilePadding: const EdgeInsets.symmetric(horizontal: 16),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            expandedAlignment: Alignment.centerLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            title: Text(
              item.question,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
            children: [
              Text(
                item.answer,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.mediumLightGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/firebase_constants.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/features/profile/presentation/widgets/settings_page_scaffold.dart';

const _categories = ['Bug', 'Idea', 'Question', 'Other'];

class HelpFeedbackScreen extends StatefulWidget {
  const HelpFeedbackScreen({super.key});

  @override
  State<HelpFeedbackScreen> createState() => _HelpFeedbackScreenState();
}

class _HelpFeedbackScreenState extends State<HelpFeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  String _category = _categories.first;
  bool _sending = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final user = fbAuth.currentUser;
    if (user == null) return;

    FocusScope.of(context).unfocus();
    setState(() => _sending = true);

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      await feedbackCollection.add({
        'uid': user.uid,
        'email': user.email,
        'category': _category,
        'message': _messageController.text.trim(),
        'platform': defaultTargetPlatform.name,
        'createdAt': FieldValue.serverTimestamp(),
      });
      messenger.showSnackBar(
        const SnackBar(content: Text('Thanks! Your feedback was sent.')),
      );
      navigator.pop();
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Could not send feedback. Please try again.'),
        ),
      );
      if (mounted) setState(() => _sending = false);
    }
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: color),
  );

  @override
  Widget build(BuildContext context) {
    return SettingsPageScaffold(
      title: 'Help & Feedback',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What is this about?',
              style: TextStyle(color: AppColors.white),
            ),
            12.heightBox,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final c in _categories)
                  ChoiceChip(
                    label: Text(c),
                    selected: _category == c,
                    showCheckmark: false,
                    selectedColor: AppColors.purple,
                    backgroundColor: AppColors.popUpBackgroundColor,
                    side: BorderSide.none,
                    labelStyle: const TextStyle(color: AppColors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    onSelected: (_) => setState(() => _category = c),
                  ),
              ],
            ),
            24.heightBox,
            const Text('Message', style: TextStyle(color: AppColors.white)),
            12.heightBox,
            TextFormField(
              controller: _messageController,
              minLines: 5,
              maxLines: 8,
              maxLength: 1000,
              textCapitalization: TextCapitalization.sentences,
              cursorColor: AppColors.white,
              style: const TextStyle(color: AppColors.white),
              decoration: InputDecoration(
                hintText: "Tell us what happened or what you'd like to see",
                hintStyle: const TextStyle(color: AppColors.mediumGray),
                filled: true,
                fillColor: AppColors.eerieBlack,
                contentPadding: const EdgeInsets.all(12),
                border: _border(AppColors.mediumGray),
                enabledBorder: _border(AppColors.mediumGray),
                focusedBorder: _border(AppColors.purple),
              ),
              validator: (value) => (value ?? '').trim().length < 10
                  ? 'Please write at least 10 characters'
                  : null,
            ),
            24.heightBox,
            SizedBox(
              width: double.infinity,
              child: UpToDoButton(
                text: _sending ? 'Sending...' : 'Send',
                textColour: AppColors.white,
                backgroundColour: AppColors.purple,
                onPressed: _sending ? null : _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
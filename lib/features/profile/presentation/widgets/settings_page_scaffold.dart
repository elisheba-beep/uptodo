import 'package:flutter/material.dart';
import 'package:uptodo/core/constant/app_colors.dart';

class SettingsPageScaffold extends StatelessWidget {
  const SettingsPageScaffold({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.white,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            letterSpacing: -0.5,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: child,
        ),
      ),
    );
  }
}
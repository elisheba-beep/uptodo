import 'package:flutter/material.dart';
import 'package:uptodo/core/constant/app_colors.dart';

class TaskTextfield extends StatelessWidget {
  const TaskTextfield({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.hintText,
    required this.borderColor,
    required this.hasText,
  });

  final TextEditingController controller;
  final Function(String?) onChanged;
  final String hintText;
  final Color borderColor;
  final bool hasText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      cursorColor: AppColors.white,
      style: TextStyle(color: AppColors.white, fontSize: 18),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.transparent,
        filled: true,
        contentPadding: hasText
            ? EdgeInsets.symmetric(horizontal: 16, vertical: 8)
            : EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        isDense: true,
        border: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
      ),
    );
  }
}

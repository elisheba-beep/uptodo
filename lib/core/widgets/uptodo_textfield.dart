import 'package:flutter/material.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';

class UpToDoTextField extends StatelessWidget {
  const UpToDoTextField({
    super.key,
    required this.controller,
    this.obscureText = false,
    required this.label,
    required this.hintText,
    required this.onChanged,
  });

  final TextEditingController controller;
  final bool obscureText;
  final String label;
  final String hintText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: AppColors.white)),
        15.heightBox,
        TextFormField(
          onChanged: onChanged,
          controller: controller,
          obscureText: obscureText,
          cursorColor: AppColors.white,
          style: TextStyle(color: AppColors.white),
          decoration: InputDecoration(
            hintText: hintText,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            fillColor: AppColors.eerieBlack,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: AppColors.mediumGray, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: AppColors.mediumGray, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}

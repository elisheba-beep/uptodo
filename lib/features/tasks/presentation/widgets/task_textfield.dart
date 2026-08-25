import 'package:flutter/material.dart';

class TaskTextfield extends StatelessWidget {
  const TaskTextfield({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.hintText,
    required this.borderColor,
  });

  final TextEditingController controller;
  final Function(String?) onChanged;
  final String hintText;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.transparent,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),
      ),
    );
  }
}

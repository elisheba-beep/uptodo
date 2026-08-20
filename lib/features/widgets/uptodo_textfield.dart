import 'package:flutter/material.dart';

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
        Text(label, style: TextStyle(color: Colors.white)),
        SizedBox(height: 15),
        TextFormField(
          onChanged: onChanged,
          controller: controller,
          obscureText: obscureText,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            fillColor: Color(0xff1d1d1d),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Color(0xff979797), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Color(0xff979797), width: 1),
            ),
            
          ),
        ),
      ],
    );
  }
}

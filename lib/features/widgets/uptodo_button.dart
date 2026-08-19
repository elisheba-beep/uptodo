import 'package:flutter/material.dart';

class UpToDoButton extends StatelessWidget {
  const UpToDoButton({
    super.key,
    required this.text,
    required this.textColour,
    required this.backgroundColour,
    required this.onPressed,
    this.border = false,
  });

  final String text;
  final Color textColour;
  final Color backgroundColour;
  final void Function()? onPressed;
  final bool border;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,

      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColour,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: border ? BorderSide(width: 1, color: Color(0xff8875FF)) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          text,
          style: TextStyle(
            color: textColour,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

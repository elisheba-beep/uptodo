import 'package:flutter/material.dart';
import 'package:uptodo/core/constant/app_colors.dart';

class UpToDoButton extends StatelessWidget {
  const UpToDoButton({
    super.key,
    required this.text,
    required this.textColour,
    required this.backgroundColour,
    required this.onPressed,
    this.border = false,
    this.hasIcon = false,
    this.icon,
    this.disabled=false,
  });

  final String text;
  final Color textColour;
  final Widget? icon;
  final bool hasIcon;
  final Color backgroundColour;
  final void Function()? onPressed;
  final bool border;
  final bool disabled;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColour,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: border ? BorderSide(width: 1, color: AppColors.purple) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hasIcon ? icon! : Text(''),
            SizedBox(width: hasIcon ? 8 : 0),
            Text(
              text,
              style: TextStyle(
                color: textColour,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

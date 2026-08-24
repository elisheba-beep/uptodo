import 'package:flutter/material.dart';
import 'package:uptodo/features/constant/app_colors.dart';
import 'package:uptodo/features/constant/size_boxes.dart';
import 'package:uptodo/features/widgets/uptodo_button.dart';

class FingerprintScanner extends StatelessWidget {
  const FingerprintScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      backgroundColor: Color(0xff363636),
      onClosing: () {},
      builder: (context) => Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Icon(Icons.fingerprint, color: Colors.white, size: 78),
            ),
            24.heightBox,
            Text(
              'Please hold your finger at the fingerprint scanner to verify your identity',
              style: TextStyle(color: Colors.white),
            ),
            50.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UpToDoButton(
                  text: 'Cancel',
                  textColour: AppColors.appPurple,
                  backgroundColour: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                UpToDoButton(
                  text: 'Use Password',
                  textColour: Colors.white,
                  backgroundColour: AppColors.appPurple,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

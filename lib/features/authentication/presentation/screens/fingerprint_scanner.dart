import 'package:flutter/material.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';

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
      backgroundColor: AppColors.popUpBackgroundColor,
      onClosing: () {},
      builder: (context) => Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Icon(Icons.fingerprint, color: AppColors.white, size: 78),
            ),
            24.heightBox,
            Text(
              'Please hold your finger at the fingerprint scanner to verify your identity',
              style: TextStyle(color: AppColors.white),
            ),
            50.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UpToDoButton(
                  text: 'Cancel',
                  textColour: AppColors.purple,
                  backgroundColour: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                UpToDoButton(
                  text: 'Use Password',
                  textColour: AppColors.white,
                  backgroundColour: AppColors.purple,
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

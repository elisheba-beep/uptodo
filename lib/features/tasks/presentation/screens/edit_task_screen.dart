import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptodo/core/constant/app_colors.dart';

class EditTaskScreen extends ConsumerStatefulWidget {
  const EditTaskScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends ConsumerState<EditTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, color: AppColors.white, size: 32),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.repeat, color: AppColors.white, size: 32),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 24),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            ListTile(
              
            ),
          ],
        ),
      ),
    );
  }
}

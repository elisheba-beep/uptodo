import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/navigation.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/features/authentication/presentation/screens/login_screen.dart';
import 'package:uptodo/features/profile/data/settings/settings_data.dart';
import 'package:uptodo/features/profile/presentation/widgets/settings_tile.dart';
import 'package:uptodo/features/tasks/domain/models/task_model.dart';
import 'package:uptodo/features/tasks/presentation/providers/filtered_tasks/filtered_tasks_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final activeTasks = ref.watch(filteredTasksProvider(Filter.active));
    final completedTasks = ref.watch(filteredTasksProvider(Filter.completed));
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(
                  'assets/images/profile_picture.png',
                ),
                radius: 42.5,
              ),
            ),
            10.heightBox,
            Center(
              child: Text(
                'Martha Hays',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
            ),
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UpToDoButton(
                  text:
                      '${activeTasks.length} Task${activeTasks.length != 1 ? 's' : ''} Left',
                  textColour: AppColors.white,
                  backgroundColour: AppColors.popUpBackgroundColor,
                  onPressed: () {},
                ),
                UpToDoButton(
                  text:
                      '${completedTasks.length} Task${completedTasks.length != 1 ? 's' : ''} Done',
                  textColour: AppColors.white,
                  backgroundColour: AppColors.popUpBackgroundColor,
                  onPressed: () {},
                ),
              ],
            ),
            32.heightBox,
            Text(
              'Settings',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
              ),
            ),
            4.heightBox,
            SettingsTile(
              title: 'App Settings',
              icon: Icons.settings,
              onTap: () {},
            ),
            16.heightBox,
            Text(
              'Account',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
              ),
            ),
            4.heightBox,
            ListView.builder(
              shrinkWrap: true,
              itemCount: accountSettings.length,
              itemBuilder: (BuildContext context, int index) {
                final setting = accountSettings[index];
                return SettingsTile(
                  title: setting.title,
                  icon: setting.icon,
                  onTap: setting.onTap,
                );
              },
            ),
            16.heightBox,
            Text(
              'UpToDo',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
              ),
            ),
            4.heightBox,
            ListView.builder(
              shrinkWrap: true,
              itemCount: upToDoSettings.length,
              itemBuilder: (BuildContext context, int index) {
                final setting = upToDoSettings[index];
                return SettingsTile(
                  title: setting.title,
                  icon: setting.icon,
                  onTap: setting.onTap,
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
              dense: true,
              tileColor: Colors.transparent,
              onTap: () {
                context.pushReplacement(LoginScreen());
              },
              leading: Icon(
                Icons.door_back_door,
                size: 24,
                color: AppColors.red,
              ),
              title: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

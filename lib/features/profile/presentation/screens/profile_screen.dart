import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/firebase_constants.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/utils/avatar_image.dart';
import 'package:uptodo/core/utils/error_dialog.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/features/authentication/data/models/custom_error.dart';
import 'package:uptodo/features/authentication/domain/repositories/auth_repository_provider.dart';
import 'package:uptodo/features/profile/data/settings/settings_data.dart';
import 'package:uptodo/features/profile/domain/repositories/profile_repository_provider.dart';
import 'package:uptodo/features/profile/presentation/widgets/change_account_image.dart';
import 'package:uptodo/features/profile/presentation/widgets/change_name_dialog.dart';
import 'package:uptodo/features/profile/presentation/widgets/change_password_dialog.dart';
import 'package:uptodo/features/profile/presentation/widgets/settings_tile.dart';
import 'package:uptodo/features/tasks/domain/models/task_model.dart';
import 'package:uptodo/features/tasks/presentation/providers/filtered_tasks/filtered_tasks_provider.dart';
import 'package:uptodo/features/tasks/presentation/providers/home/home_provider.dart';

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
    final uid = fbAuth.currentUser!.uid;
    final profileState = ref.watch(profileProvider(uid));
    bool uploadingImage = false;

    return SingleChildScrollView(
      child: profileState.when(
        data: (appUser) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 42.5,
                        backgroundImage: avatarImage(appUser.profilePic),
                      ),
                      if (uploadingImage) const CircularProgressIndicator(),
                    ],
                  ),
                ),
                10.heightBox,
                Center(
                  child: Text(
                    appUser.name,
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

                SettingsTile(
                  title: 'Change account name',
                  icon: Icons.person_outline,
                  onTap: () async {
                    final newName = await showDialog<String>(
                      context: context,
                      builder: (context) =>
                          ChangeNameDialog(currentName: appUser.name),
                    );
                    if (newName != null) {
                      ref.invalidate(profileProvider(uid));
                    }
                  },
                ),

                SettingsTile(
                  title: 'Change account password',
                  icon: Icons.key_outlined,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const ChangePasswordDialog(),
                    );
                  },
                ),

                SettingsTile(
                  title: 'Change account Image',
                  icon: Icons.camera_alt_outlined,
                  onTap: () async {
                    final selectedSource =
                        await showModalBottomSheet<ImageSourceType>(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const ChangeImageModal(),
                        );

                    if (selectedSource == null) return;
                    final repo = ref.read(profileRepositoryProvider);
                    try {
                      final file = await repo.pickImage(
                        selectedSource == ImageSourceType.camera
                            ? ImageSource.camera
                            : ImageSource.gallery,
                      );
                      if (file == null) return;

                      setState(() => uploadingImage = true);

                      await repo.uploadProfilePicture(file: file, uid: uid);
                      ref.invalidate(profileProvider(uid));
                    } on CustomError catch (e) {
                      if (!context.mounted) return;
                      errorDialog(context, e);
                    } finally {
                      if (mounted) setState(() => uploadingImage = false);
                    }
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
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 12,
                  ),
                  dense: true,
                  tileColor: Colors.transparent,
                  onTap: () async {
                    try {
                      await ref.read(authRepositoryProvider).signOut();
                    } on CustomError catch (e) {
                      if (!context.mounted) return;
                      errorDialog(context, e);
                    }
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
          );
        },
        error: (e, _) {
          final error = e as CustomError;

          return Center(
            child: Text(
              'code: ${error.code}\nplugin: ${error.plugin}\nmessage: ${error.message}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

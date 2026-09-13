import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/providers/theme/theme_provider.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_draft/task_draft_provider.dart';
import 'package:uptodo/features/tasks/presentation/widgets/add_task_modal.dart';
import 'package:uptodo/features/tasks/presentation/screens/home_screen.dart';

class IndexScreen extends ConsumerStatefulWidget {
  const IndexScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IndexScreenState();
}

class _IndexScreenState extends ConsumerState<IndexScreen> {
  int currentScreenIndex = 0;

  List screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 56,
        leading: IconButton(
          onPressed: () {
            ref.read(themeProvider.notifier).toggleTheme();
          },
          icon: Icon(Icons.filter_list, color: AppColors.white),
        ),
        title: Text(
          'Index',
          style: TextStyle(
            fontSize: 20,
            letterSpacing: -0.5,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          CircleAvatar(child: Image.asset('assets/images/profile_picture.png')),
        ],
        actionsPadding: EdgeInsets.only(right: 24),
      ),
      body: screens[currentScreenIndex],
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        shape: const CircleBorder(),
        backgroundColor: AppColors.purple,
        onPressed: () {
          ref.read(taskDraftProvider.notifier).startCreatingTask();
          showDialog(context: context, builder: (context) => AddTaskModal());
        },
        child: Icon(Icons.add, color: AppColors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 100,
        child: BottomNavigationBar(
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.white,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.popUpBackgroundColor,
          currentIndex: currentScreenIndex,
          onTap: (index) {
            if (index == 2) return;
            setState(() {
              currentScreenIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/home.svg'),
              activeIcon: SvgPicture.asset('assets/icons/home-2.svg'),
              label: 'Index',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/calendar.svg'),
              activeIcon: SvgPicture.asset('assets/icons/calendar-2.svg'),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Opacity(opacity: 0, child: Icon(Icons.add)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/clock.svg'),
              activeIcon: SvgPicture.asset('assets/icons/clock-2.svg'),
              label: 'Focuse',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/user.svg'),
              activeIcon: SvgPicture.asset('assets/icons/user.svg'),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

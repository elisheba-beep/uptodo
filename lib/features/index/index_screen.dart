import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptodo/features/index/add_task_modal.dart';
import 'package:uptodo/features/index/home_screen.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
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
      backgroundColor: Color(0xff121212),
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        elevation: 0,
        leadingWidth: 56,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.filter_list, color: Colors.white),
        ),
        title: Text(
          'Index',
          style: TextStyle(
            fontSize: 20,
            letterSpacing: -0.5,
            color: Colors.white,
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
        backgroundColor: Color(0xff8875FF),
        onPressed: () {
          showDialog(context: context, builder: (context) => AddTaskModal());
        },
        child: Icon(Icons.add, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 100,
        child: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xff363636),
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

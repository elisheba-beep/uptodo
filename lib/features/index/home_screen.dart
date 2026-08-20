import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          SvgPicture.asset('assets/images/index.svg', height: 227),
          Text(
            'What do you want to do today?',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Tap + to add your tasks',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

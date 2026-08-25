import 'package:flutter/material.dart';
import 'package:uptodo/features/authentication/presentation/screens/login_screen.dart';
import 'package:uptodo/features/authentication/presentation/screens/register_screen.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Welcome to UpTodo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  textAlign: TextAlign.center,
                  'Please login to your account or create new account to continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UpToDoButton(
                  text: 'LOGIN',
                  textColour: Colors.white,
                  backgroundColour: Color(0xff8875FF),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
                SizedBox(height: 15),
                UpToDoButton(
                  text: 'CREATE ACCOUNT',
                  textColour: Colors.white,
                  backgroundColour: Color(0xff121212),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  border: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

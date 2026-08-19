import 'package:flutter/material.dart';
import 'package:uptodo/features/loginRegister/login_screen.dart';
import 'package:uptodo/features/widgets/uptodo_button.dart';
import 'package:uptodo/features/widgets/uptodo_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                textAlign: TextAlign.left,
                'Register',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 30),
              UpToDoTextField(
                controller: usernameController,
                label: 'Username',
                hintText: 'Enter your Username',
              ),
              SizedBox(height: 10),
              UpToDoTextField(
                controller: passwordController,
                label: 'Password',
                hintText: '...................',
                obscureText: true,
              ),
              SizedBox(height: 10),
              UpToDoTextField(
                controller: confirmPasswordController,
                label: 'Confirm Password',
                hintText: '...................',
                obscureText: true,
              ),
              SizedBox(height: 50),
              UpToDoButton(
                text: 'Register',
                textColour: Colors.white,
                backgroundColour: Color(0xff8875FF),
                onPressed: () {},
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: Color(0xff979797),
                      height: 2,
                      endIndent: 16,
                    ),
                  ),
                  Text('or', style: TextStyle(color: Color(0xff979797))),
                  Expanded(
                    child: Divider(
                      color: Color(0xff979797),
                      height: 2,
                      indent: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              UpToDoButton(
                text: 'Register with Google',
                textColour: Colors.white,
                backgroundColour: Color(0xff121212),
                onPressed: () {},
                border: true,
              ),
              SizedBox(height: 10),
              UpToDoButton(
                text: 'Register with Apple',
                textColour: Colors.white,
                backgroundColour: Color(0xff121212),
                onPressed: () {},
                border: true,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(color: Color(0xff7a7a7a)),
                  ),
                  GestureDetector(
                    child: Text('Login', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

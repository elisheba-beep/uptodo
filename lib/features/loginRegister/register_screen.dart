import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptodo/features/index/index_screen.dart';
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

  bool usernameHasText = false;
  bool passwordHasText = false;
  bool confirmPasswordHasText = false;

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
                onChanged: (text) {
                  bool hasText = text.trim().isNotEmpty;
                  if (hasText != usernameHasText) {
                    setState(() {
                      usernameHasText = hasText;
                    });
                  }
                },
                controller: usernameController,
                label: 'Username',
                hintText: 'Enter your Username',
              ),
              SizedBox(height: 20),
              UpToDoTextField(
                onChanged: (text) {
                  bool hasText = text.trim().isNotEmpty;
                  if (hasText != passwordHasText) {
                    setState(() {
                      passwordHasText = hasText;
                    });
                  }
                },
                controller: passwordController,
                label: 'Password',
                hintText: '...................',
                obscureText: true,
              ),
              SizedBox(height: 20),
              UpToDoTextField(
                onChanged: (text) {
                  bool hasText = text.trim().isNotEmpty;
                  if (hasText != confirmPasswordHasText) {
                    setState(() {
                      confirmPasswordHasText = hasText;
                    });
                  }
                },
                controller: confirmPasswordController,
                label: 'Confirm Password',
                hintText: '...................',
                obscureText: true,
              ),
              SizedBox(height: 50),
              UpToDoButton(
                text: 'Register',
                textColour:
                    (usernameHasText &&
                        passwordHasText &&
                        confirmPasswordHasText)
                    ? Colors.white
                    : Color(0xff979797),
                backgroundColour:
                    (usernameHasText &&
                        passwordHasText &&
                        confirmPasswordHasText)
                    ? Color(0xff8875FF)
                    : Color(0xff8687E7).withValues(alpha: 0.5),
                onPressed: () {
                  (usernameHasText && passwordHasText && confirmPasswordHasText)
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IndexScreen(),
                          ),
                        )
                      : null;
                },
              ),
              SizedBox(height: 25),
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
              SizedBox(height: 25),
              UpToDoButton(
                hasIcon: true,
                icon: SvgPicture.asset('assets/icons/google.svg'),
                text: 'Register with Google',
                textColour: Colors.white,
                backgroundColour: Color(0xff121212),
                onPressed: () {},
                border: true,
              ),
              SizedBox(height: 15),
              UpToDoButton(
                hasIcon: true,
                icon: SvgPicture.asset('assets/icons/apple.svg'),
                text: 'Register with Apple',
                textColour: Colors.white,
                backgroundColour: Color(0xff121212),
                onPressed: () {},
                border: true,
              ),
              SizedBox(height: 35),
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
                      Navigator.pushReplacement(
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

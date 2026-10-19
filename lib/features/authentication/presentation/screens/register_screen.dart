import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/navigation.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/features/tasks/presentation/screens/index_screen.dart';
import 'package:uptodo/features/authentication/presentation/screens/login_screen.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/core/widgets/uptodo_textfield.dart';

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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: AppColors.white),
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
                  color: AppColors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              30.heightBox,
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
              20.heightBox,
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
              20.heightBox,
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
              50.heightBox,
              UpToDoButton(
                text: 'Register',
                textColour:
                    (usernameHasText &&
                        passwordHasText &&
                        confirmPasswordHasText)
                    ? AppColors.white
                    : AppColors.mediumLightGray,
                backgroundColour:
                    (usernameHasText &&
                        passwordHasText &&
                        confirmPasswordHasText)
                    ? Color(0xff8875FF)
                    : AppColors.lightPurple.withValues(alpha: 0.5),
                onPressed: () {
                  (usernameHasText && passwordHasText && confirmPasswordHasText)
                      ? context.pushReplacement(IndexScreen())
                      : null;
                },
              ),
              25.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColors.mediumLightGray,
                      height: 2,
                      endIndent: 16,
                    ),
                  ),
                  Text(
                    'or',
                    style: TextStyle(color: AppColors.mediumLightGray),
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColors.mediumLightGray,
                      height: 2,
                      indent: 16,
                    ),
                  ),
                ],
              ),
              25.heightBox,
              UpToDoButton(
                hasIcon: true,
                icon: SvgPicture.asset('assets/icons/google.svg'),
                text: 'Register with Google',
                textColour: AppColors.white,
                backgroundColour: AppColors.backgroundColor,
                onPressed: () {},
                border: true,
              ),
              SizedBox(height: 15),
              UpToDoButton(
                hasIcon: true,
                icon: SvgPicture.asset('assets/icons/apple.svg'),
                text: 'Register with Apple',
                textColour: AppColors.white,
                backgroundColour: AppColors.backgroundColor,
                onPressed: () {},
                border: true,
              ),
              35.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(color: AppColors.mediumDarkGray),
                  ),
                  GestureDetector(
                    child: Text(
                      'Login',
                      style: TextStyle(color: AppColors.white),
                    ),
                    onTap: () {
                      context.pushReplacement(LoginScreen());
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

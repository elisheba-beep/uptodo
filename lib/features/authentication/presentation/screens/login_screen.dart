import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/navigation.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/features/tasks/presentation/screens/index_screen.dart';
import 'package:uptodo/features/authentication/presentation/screens/fingerprint_scanner.dart';
import 'package:uptodo/features/authentication/presentation/screens/register_screen.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/core/widgets/uptodo_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;

  bool usernameHasText = false;
  bool passwordHasText = false;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
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
                'Login',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              50.heightBox,
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
              30.heightBox,
              Center(
                child: IconButton(
                  icon: Icon(Icons.fingerprint, color: AppColors.white),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return FingerprintScanner();
                      },
                    );
                  },
                ),
              ),
              25.heightBox,
              UpToDoButton(
                text: 'Login',
                textColour: (usernameHasText && passwordHasText)
                    ? AppColors.white
                    : AppColors.mediumGray,
                backgroundColour: (usernameHasText && passwordHasText)
                    ? AppColors.purple
                    : AppColors.lightPurple.withValues(alpha: 0.5),
                onPressed: () {
                  (usernameHasText && passwordHasText)
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
                      color: AppColors.mediumGray,
                      height: 2,
                      endIndent: 16,
                    ),
                  ),
                  Text('or', style: TextStyle(color: AppColors.mediumGray)),
                  Expanded(
                    child: Divider(
                      color: AppColors.mediumGray,
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
                text: 'Login with Google',
                textColour: AppColors.white,
                backgroundColour: AppColors.backgroundColor,
                onPressed: () {},
                border: true,
              ),
              15.heightBox,
              UpToDoButton(
                hasIcon: true,
                icon: SvgPicture.asset('assets/icons/apple.svg'),
                text: 'Login with Apple',
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
                    'Dont have an account? ',
                    style: TextStyle(color: AppColors.mediumDarkGray),
                  ),
                  GestureDetector(
                    child: Text(
                      'Register',
                      style: TextStyle(color: AppColors.white),
                    ),
                    onTap: () {
                      context.pushReplacement(RegisterScreen());
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

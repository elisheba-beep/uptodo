import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uptodo/core/constant/app_colors.dart';
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
      backgroundColor: AppColors.backgroundColor,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 50),
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
              30.heightBox,
              Center(
                child: IconButton(
                  icon: Icon(Icons.fingerprint, color: Colors.white),
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
                    ? Colors.white
                    : Color(0xff979797),
                backgroundColour: (usernameHasText && passwordHasText)
                    ? Color(0xff8875FF)
                    : Color(0xff8687E7).withValues(alpha: 0.5),
                onPressed: () {
                  (usernameHasText && passwordHasText)
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
                text: 'Login with Google',
                textColour: Colors.white,
                backgroundColour: Color(0xff121212),
                onPressed: () {},
                border: true,
              ),
              SizedBox(height: 15),
              UpToDoButton(
                hasIcon: true,
                icon: SvgPicture.asset('assets/icons/apple.svg'),
                text: 'Login with Apple',
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
                    'Dont have an account? ',
                    style: TextStyle(color: Color(0xff7a7a7a)),
                  ),
                  GestureDetector(
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
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

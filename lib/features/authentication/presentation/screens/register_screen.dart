import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/router/route_names.dart';
import 'package:uptodo/core/utils/error_dialog.dart';
import 'package:uptodo/features/authentication/data/models/custom_error.dart';
import 'package:uptodo/features/authentication/presentation/providers/signup/signup_provider.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/core/widgets/uptodo_textfield.dart';
import 'package:validators/validators.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  void _submit() {
    setState(() {
      autoValidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    ref
        .read(signupProvider.notifier)
        .signup(
          name: usernameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
  }

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    usernameController.addListener(_onFieldChanged);
    emailController.addListener(_onFieldChanged);
    passwordController.addListener(_onFieldChanged);
    confirmPasswordController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    usernameController.removeListener(_onFieldChanged);
    emailController.removeListener(_onFieldChanged);
    passwordController.removeListener(_onFieldChanged);
    confirmPasswordController.removeListener(_onFieldChanged);

    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    final name = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirm = confirmPasswordController.text;
    return name.length >= 2 &&
        name.length <= 12 &&
        isEmail(email) &&
        password.length >= 6 &&
        password == confirm;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(signupProvider, (previous, next) {
      next.whenOrNull(
        error: (e, st) => errorDialog(context, (e as CustomError)),
      );
    });

    final signupState = ref.watch(signupProvider);
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
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              autovalidateMode: autoValidateMode,
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
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Name required';
                      }
                      if (value.trim().length < 2 || value.trim().length > 12) {
                        return 'Name must be between 2 and 12 characters long';
                      }
                      return null;
                    },

                    controller: usernameController,
                    label: 'Username',
                    hintText: 'Enter your Username',
                  ),
                  20.heightBox,
                  UpToDoTextField(
                    keyboardType: TextInputType.emailAddress,
                    autoCorrect: false,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email required';
                      }
                      if (!isEmail(value.trim())) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },

                    controller: emailController,
                    label: 'Email',
                    hintText: 'Enter your Email',
                  ),
                  20.heightBox,
                  UpToDoTextField(
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Password required';
                      }
                      if (value.trim().length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },

                    controller: passwordController,
                    label: 'Password',
                    hintText: '...................',
                    obscureText: true,
                  ),
                  20.heightBox,
                  UpToDoTextField(
                    validator: (String? value) {
                      if (passwordController.text != value) {
                        return 'Passwords not match';
                      }
                      return null;
                    },

                    controller: confirmPasswordController,
                    label: 'Confirm Password',
                    hintText: '...................',
                    obscureText: true,
                  ),
                  50.heightBox,
                  UpToDoButton(
                    text: signupState.isLoading ? 'Registering...' : 'Register',
                    textColour: _isFormValid
                        ? AppColors.white
                        : AppColors.mediumLightGray,
                    backgroundColour: _isFormValid
                        ? const Color(0xff8875FF)
                        : AppColors.lightPurple.withValues(alpha: 0.5),
                    onPressed: (_isFormValid && !signupState.isLoading)
                        ? _submit
                        : null,
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
                        onTap: signupState.maybeWhen(
                          loading: () => null,
                          orElse: () =>
                              () => GoRouter.of(
                                context,
                              ).goNamed(RouteNames.signin),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

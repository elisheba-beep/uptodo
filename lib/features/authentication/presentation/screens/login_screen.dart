import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/router/route_names.dart';
import 'package:uptodo/core/utils/error_dialog.dart';
import 'package:uptodo/features/authentication/data/models/custom_error.dart';
import 'package:uptodo/features/authentication/presentation/providers/signin/signin_provider.dart';
import 'package:uptodo/features/authentication/presentation/screens/fingerprint_scanner.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/core/widgets/uptodo_textfield.dart';
import 'package:validators/validators.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  bool usernameHasText = false;
  bool passwordHasText = false;

  void _submit() {
    setState(() {
      autoValidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    ref
        .read(signinProvider.notifier)
        .signin(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    emailController.addListener(_onFieldChanged);
    passwordController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    emailController.removeListener(_onFieldChanged);
    passwordController.removeListener(_onFieldChanged);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    final email = emailController.text.trim();
    final password = passwordController.text;
    return isEmail(email) && password.length >= 6;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(signinProvider, (previous, next) {
      next.whenOrNull(
        error: (e, st) => errorDialog(context, (e as CustomError)),
      );
    });

    final signinState = ref.watch(signinProvider);

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
                    'Login',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  50.heightBox,
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
                    text: signinState.isLoading ? 'Logging in...' : 'Login',
                    textColour: _isFormValid
                        ? AppColors.white
                        : AppColors.mediumLightGray,
                    backgroundColour: _isFormValid
                        ? const Color(0xff8875FF)
                        : AppColors.lightPurple.withValues(alpha: 0.5),
                    onPressed: (_isFormValid && !signinState.isLoading)
                        ? _submit
                        : null,
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
                        onTap: signinState.maybeWhen(
                          loading: () => null,
                          orElse: () =>
                              () => GoRouter.of(
                                context,
                              ).goNamed(RouteNames.signup),
                        ),
                        child: Text(
                          'Register',
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

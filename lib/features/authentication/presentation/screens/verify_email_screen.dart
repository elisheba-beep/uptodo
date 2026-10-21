import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/utils/error_dialog.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/features/authentication/data/models/custom_error.dart';
import 'package:uptodo/features/authentication/domain/repositories/auth_repository_provider.dart';

class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  Timer? _timer;
  Timer? _resendTimer;
  int _resendCountdown = 30;
  bool _canResend = true;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _sendVerificationEmail());

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _checkEmailVerified();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _resendTimer?.cancel();
    super.dispose();
  }

  Future<void> _sendVerificationEmail() async {
    try {
      await ref.read(authRepositoryProvider).sendEmailVerification();
    } catch (e) {
      if (mounted && e is CustomError) {
        errorDialog(context, e);
      }
    }
  }

  Future<void> _checkEmailVerified() async {
    if (_isChecking) return;
    _isChecking = true;

    try {
      final authRepo = ref.read(authRepositoryProvider);
      await authRepo.reloadUser();

      if (authRepo.currentUser?.emailVerified ?? false) {
        _timer?.cancel();
        ref.invalidate(authStateStreamProvider);
      }
    } catch (_) {
    } finally {
      _isChecking = false;
    }
  }

  void _startResendCooldown() {
    setState(() {
      _canResend = false;
      _resendCountdown = 30;
    });

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 1) {
        setState(() => _resendCountdown--);
      } else {
        timer.cancel();
        setState(() => _canResend = true);
      }
    });
  }

  Future<void> _handleResend() async {
    if (!_canResend) return;

    await _sendVerificationEmail();
    _startResendCooldown();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification email sent. Please check your inbox.'),
          backgroundColor: AppColors.popUpBackgroundColor,
        ),
      );
    }
  }

  Future<void> _manualCheck() async {
    setState(() => _isChecking = true);
    await _checkEmailVerified();

    if (mounted) {
      final isVerified =
          ref.read(authRepositoryProvider).currentUser?.emailVerified ?? false;
      if (!isVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Email not verified yet. Please click the link in your email.',
            ),
            backgroundColor: AppColors.popUpBackgroundColor,
          ),
        );
      }
      setState(() => _isChecking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authRepositoryProvider).currentUser;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Sign Out',
            onPressed: () async {
              _timer?.cancel();
              await ref.read(authRepositoryProvider).signOut();
            },
            icon: const Icon(Icons.logout, color: AppColors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.purple.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mark_email_unread_outlined,
                    color: AppColors.purple,
                    size: 52,
                  ),
                ),
              ),
              32.heightBox,

              const Text(
                'Verify your email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              16.heightBox,

              const Text(
                'We have sent a verification link to:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.mediumLightGray,
                  fontSize: 16,
                ),
              ),
              8.heightBox,
              Text(
                user?.email ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              16.heightBox,
              const Text(
                'Please click the link in the email to activate your account. If you don\'t see it, be sure to check your spam folder.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.mediumDarkGray,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),

              const Spacer(),

              UpToDoButton(
                text: _isChecking ? 'Checking...' : 'I have verified',
                textColour: AppColors.white,
                backgroundColour: AppColors.purple,
                onPressed: _isChecking ? null : _manualCheck,
              ),
              16.heightBox,

              UpToDoButton(
                text: _canResend
                    ? 'Resend verification email'
                    : 'Resend in ${_resendCountdown}s',
                textColour: _canResend ? AppColors.white : AppColors.mediumGray,
                backgroundColour: AppColors.backgroundColor,
                border: true,
                onPressed: _canResend ? _handleResend : null,
              ),
              24.heightBox,

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Wrong email? ',
                    style: TextStyle(color: AppColors.mediumDarkGray),
                  ),
                  GestureDetector(
                    onTap: () async {
                      _timer?.cancel();
                      await ref.read(authRepositoryProvider).signOut();
                    },
                    child: const Text(
                      'Sign out',
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              16.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}

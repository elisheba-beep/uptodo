import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uptodo/core/router/route_names.dart';
import 'package:uptodo/features/authentication/domain/repositories/auth_repository_provider.dart';
import 'package:uptodo/features/authentication/presentation/screens/firebase_error_screen.dart';
import 'package:uptodo/features/authentication/presentation/screens/login_screen.dart';
import 'package:uptodo/features/authentication/presentation/screens/page_not_found.dart';
import 'package:uptodo/features/authentication/presentation/screens/register_screen.dart';
import 'package:uptodo/features/onboarding/presentation/providers/onboarding_completed_provider.dart';
import 'package:uptodo/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:uptodo/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:uptodo/features/onboarding/presentation/screens/start_screen.dart';
import 'package:uptodo/features/tasks/presentation/screens/index_screen.dart';

part 'router_provider.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final authState = ref.watch(authStateStreamProvider);
  final hasSeenOnboarding = ref.watch(onboardingCompletedProvider);
  return GoRouter(
    redirect: (context, state) {
      if (authState is AsyncLoading<User?>) {
        return state.matchedLocation == '/splash' ? null : '/splash';
      }
      if (authState is AsyncError<User?>) {
        return state.matchedLocation == '/firebaseError'
            ? null
            : '/firebaseError';
      }
      final user = authState.value;
      final authenticated = user != null;

      final inAuthOrOnboardingFlow =
          (state.matchedLocation == '/start') ||
          (state.matchedLocation == '/onboarding') ||
          (state.matchedLocation == '/signin') ||
          (state.matchedLocation == '/signup');

      if (!authenticated) {
        if (inAuthOrOnboardingFlow) {
          return null;
        }

        return hasSeenOnboarding ? '/start' : '/onboarding';
      }

      // if (!user.emailVerified) {
      //   return state.matchedLocation == '/verifyEmail' ? null : '/verifyEmail';
      // }

      final verifyingEmail = (state.matchedLocation == '/verifyEmail');
      final splashing = (state.matchedLocation == '/splash');

      if (inAuthOrOnboardingFlow || verifyingEmail || splashing) {
        return state.matchedLocation == '/home' ? null : '/home';
      }

      return null;
    },
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/onboarding',
        name: RouteNames.onboarding,
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),
      GoRoute(
        path: '/start',
        name: RouteNames.start,
        builder: (context, state) {
          return const StartScreen();
        },
      ),
      GoRoute(
        path: '/splash',
        name: RouteNames.splash,
        builder: (context, state) {
          print('--------------splash-------------');
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: '/fireaseError',
        name: RouteNames.firebaseError,
        builder: (context, state) {
          print('--------------firebase error-------------');
          return const FirebaseErrorScreen();
        },
      ),
      GoRoute(
        path: '/signin',
        name: RouteNames.signin,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/signup',
        name: RouteNames.signup,
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: '/home',
        name: RouteNames.home,
        builder: (context, state) {
          return const IndexScreen();
        },
      ),
    ],
    errorBuilder: (context, state) {
      return PageNotFound(errorMessage: state.error.toString());
    },
  );
}

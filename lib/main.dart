import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/providers/theme/theme_provider.dart';
import 'package:uptodo/core/widgets/theme_data.dart';
import 'package:uptodo/features/onboarding/presentation/screens/onboarding_screen.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UpToDo',
      theme: theme == AppTheme.light
          ? buildTheme(Brightness.light, AppColors.backgroundColor)
          : buildTheme(Brightness.dark, AppColors.backgroundColor),
      // theme: ThemeData(
      //   fontFamily: 'Lato',
      //   scaffoldBackgroundColor: AppColors.backgroundColor,
      //   appBarTheme: AppBarTheme(
      //     backgroundColor: AppColors.backgroundColor,
      //     elevation: 0,
      //     surfaceTintColor: Colors.transparent,
      //   ),
      // ),
      home: OnboardingScreen(),
    );
  }
}

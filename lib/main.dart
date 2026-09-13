import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:riverpod_sqflite/riverpod_sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/providers/storage/storage_provider.dart';
import 'package:uptodo/core/providers/theme/theme_provider.dart';
import 'package:uptodo/features/tasks/domain/repositories/providers/tasks_repository_provider.dart';
import 'package:uptodo/core/widgets/theme_data.dart';
import 'package:uptodo/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:uptodo/features/tasks/domain/repositories/sqflite_tasks_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final tasksStorage = await JsonSqFliteStorage.open(
    join(await getDatabasesPath(), 'riverpod.db'),
  );
  runApp(
    ProviderScope(
      overrides: [
        taskStorageProvider.overrideWith((ref) => tasksStorage),
        tasksRepositoryProvider.overrideWithValue(
          SqfliteTasksRepository(tasksStorage),
        ),
      ],
      child: MyApp(),
    ),
  );
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
      home: OnboardingScreen(),
    );
  }
}

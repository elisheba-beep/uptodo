import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptodo/features/focus/presentation/providers/dnd_service.dart';

Future<bool> prepareDnd(BuildContext context, WidgetRef ref) async {
  final dnd = ref.read(dndServiceProvider);
  if (!dnd.isSupported || await dnd.hasAccess()) return true;
  if (!context.mounted) return false;

  final choice = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Silence notifications?'),
      content: const Text(
        'To mute notifications while you focus, UpToDo needs Do Not '
        'Disturb access. You will be taken to Settings to allow it. '
        'Your previous setting is restored when the session ends.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Not now'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Open settings'),
        ),
      ],
    ),
  );

  if (choice == true) {
    await dnd.openAccessSettings();
    return false;
  }
  return choice == false;
}

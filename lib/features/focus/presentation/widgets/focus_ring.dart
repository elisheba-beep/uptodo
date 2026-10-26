import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/features/focus/presentation/providers/focus_notifier.dart';
import 'package:uptodo/features/focus/presentation/providers/focus_session.dart';

final tickProvider = StreamProvider.autoDispose<DateTime>(
  (ref) =>
      Stream.periodic(const Duration(milliseconds: 250), (_) => DateTime.now()),
);

class FocusRing extends ConsumerWidget {
  const FocusRing({super.key, this.onTapTime});

  final VoidCallback? onTapTime;

  String _format(int totalSeconds) {
    final m = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(focusProvider);
    final running = session.status == FocusStatus.running;

    if (running) ref.watch(tickProvider);

    final now = DateTime.now();
    final remaining = running ? session.remaining(now) : session.duration;
    final seconds = (remaining.inMilliseconds / 1000).ceil();
    final value = running ? 1.0 - session.progress(now) : 0.0;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 213,
          height: 213,
          child: CircularProgressIndicator(
            value: value,
            backgroundColor: AppColors.mediumDarkGray,
            strokeWidth: 20,
            valueColor: AlwaysStoppedAnimation(AppColors.purple),
          ),
        ),
        GestureDetector(
          onTap: running ? null : onTapTime,
          child: Text(
            _format(seconds),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 40,
              color: AppColors.white,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ],
    );
  }
}

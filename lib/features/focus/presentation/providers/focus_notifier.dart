import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptodo/features/focus/data/storage/focus_storage.dart';
import 'package:uptodo/features/focus/presentation/providers/dnd_service.dart';
import 'package:uptodo/features/focus/presentation/providers/notification_service.dart';
import 'focus_session.dart';

final focusProvider = NotifierProvider<FocusNotifier, FocusSession>(
  FocusNotifier.new,
);

class FocusNotifier extends Notifier<FocusSession> with WidgetsBindingObserver {
  Timer? _timer;
  FocusStorage get _storage => ref.read(focusStorageProvider);

  @override
  FocusSession build() {
    WidgetsBinding.instance.addObserver(this);
    ref.onDispose(() {
      WidgetsBinding.instance.removeObserver(this);
      _timer?.cancel();
    });
    _load();
    return const FocusSession();
  }

 Future<void> _load() async {
  final preferred = await _storage.loadPreferredDuration();
  final active = await _storage.loadActive();
  final dnd = ref.read(dndServiceProvider);

  if (preferred != null) state = state.copyWith(duration: preferred);

  if (active == null) {
    await dnd.restore();
    return;
  }

  final end = active.start.add(active.duration);
  if (end.isAfter(DateTime.now())) {
    state = FocusSession(
      status: FocusStatus.running,
      duration: active.duration,
      startTime: active.start,
    );
    _startTimer();
    await ref
        .read(notificationServiceProvider)
        .scheduleFocusEnd(end.difference(DateTime.now()));
  } else {
    await _storage.clearActive();
    await dnd.restore();
    state = state.copyWith(status: FocusStatus.completed);
  }
}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) checkSession();
  }

  Future<void> selectDuration(Duration d) async {
    if (state.status == FocusStatus.running) return;
    final secs = d.inSeconds.clamp(60, 3 * 3600).toInt();
    final clamped = Duration(seconds: secs);
    state = state.copyWith(duration: clamped);
    await _storage.savePreferredDuration(clamped);
  }

Future<void> start() async {
  if (state.status == FocusStatus.running) return;
  final now = DateTime.now();
  state = state.copyWith(status: FocusStatus.running, startTime: now);
  _startTimer();
  await _storage.saveActive(now, state.duration);

  await ref.read(dndServiceProvider).enable(); 

  final notifications = ref.read(notificationServiceProvider);
  await notifications.requestPermission();
  await notifications.scheduleFocusEnd(state.remaining(DateTime.now()));
}

Future<void> stop() async {
  _timer?.cancel();
  state = state.copyWith(status: FocusStatus.idle, clearStart: true);
  await _storage.clearActive();
  await ref.read(notificationServiceProvider).cancelFocusEnd();
  await ref.read(dndServiceProvider).restore();
}

  void checkSession() {
    if (state.status != FocusStatus.running) return;
    if (state.remaining(DateTime.now()) <= Duration.zero) _complete();
  }

Future<void> _complete() async {
  if (state.status != FocusStatus.running) return;
  _timer?.cancel();
  state = state.copyWith(status: FocusStatus.completed, clearStart: true);
  await _storage.clearActive();
  await ref.read(dndServiceProvider).restore();
}

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => checkSession());
  }
}

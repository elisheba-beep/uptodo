import 'dart:io' show Platform;
import 'package:do_not_disturb/do_not_disturb.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DndService {
  static const _prevKey = 'dnd_previous_filter';

  static const _focusFilter = InterruptionFilter.priority;

  final _plugin = DoNotDisturbPlugin();

  bool get isSupported => !kIsWeb && Platform.isAndroid;

  Future<bool> hasAccess() async {
    if (!isSupported) return false;
    return _plugin.isNotificationPolicyAccessGranted();
  }

  Future<void> openAccessSettings() async {
    if (!isSupported) return;
    await _plugin.openNotificationPolicyAccessSettings();
  }

  Future<void> enable() async {
    if (!await hasAccess()) return;
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey(_prevKey)) {
      final current = await _plugin.getDNDStatus();
      await prefs.setInt(_prevKey, current.value);
    }
    await _plugin.setInterruptionFilter(_focusFilter);
  }

  Future<void> restore() async {
    if (!isSupported) return;
    final prefs = await SharedPreferences.getInstance();
    final prev = prefs.getInt(_prevKey);
    if (prev == null) return;

    if (await hasAccess()) {
      var filter = InterruptionFilter.fromValue(prev);
      if (filter == InterruptionFilter.unknown) filter = InterruptionFilter.all;
      await _plugin.setInterruptionFilter(filter);
    }
    await prefs.remove(_prevKey);
  }
}

final dndServiceProvider = Provider<DndService>((ref) => DndService());

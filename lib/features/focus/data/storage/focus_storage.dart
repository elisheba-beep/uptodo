import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActiveSession {
  const ActiveSession(this.start, this.duration);
  final DateTime start;
  final Duration duration;
}

class FocusStorage {
  static const _startKey = 'focus_start_ms';
  static const _durationKey = 'focus_duration_s';
  static const _preferredKey = 'focus_preferred_duration_s';

  Future<void> saveActive(DateTime start, Duration duration) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_startKey, start.millisecondsSinceEpoch);
    await prefs.setInt(_durationKey, duration.inSeconds);
  }

  Future<ActiveSession?> loadActive() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final startMs = prefs.getInt(_startKey);
      final secs = prefs.getInt(_durationKey);
      if (startMs == null || secs == null || secs <= 0) {
        await clearActive();
        return null;
      }
      return ActiveSession(
        DateTime.fromMillisecondsSinceEpoch(startMs),
        Duration(seconds: secs),
      );
    } catch (_) {
      await clearActive();
      return null;
    }
  }

  Future<void> clearActive() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_startKey);
    await prefs.remove(_durationKey);
  }

  Future<Duration?> loadPreferredDuration() async {
    final prefs = await SharedPreferences.getInstance();
    final secs = prefs.getInt(_preferredKey);
    return secs == null ? null : Duration(seconds: secs);
  }

  Future<void> savePreferredDuration(Duration d) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_preferredKey, d.inSeconds);
  }
}

final focusStorageProvider = Provider<FocusStorage>((ref) => FocusStorage());
enum FocusStatus { idle, running, completed }

class FocusSession {
  const FocusSession({
    this.status = FocusStatus.idle,
    this.duration = const Duration(minutes: 25),
    this.startTime,
  });

  final FocusStatus status;
  final Duration duration;
  final DateTime? startTime;

  Duration elapsed(DateTime now) {
    if (startTime == null) return Duration.zero;
    final e = now.difference(startTime!);
    if (e.isNegative) return Duration.zero;
    return e > duration ? duration : e;
  }

  Duration remaining(DateTime now) => duration - elapsed(now);

  double progress(DateTime now) {
    if (duration.inMilliseconds == 0) return 0;
    return elapsed(now).inMilliseconds / duration.inMilliseconds;
  }

  FocusSession copyWith({
    FocusStatus? status,
    Duration? duration,
    DateTime? startTime,
    bool clearStart = false,
  }) {
    return FocusSession(
      status: status ?? this.status,
      duration: duration ?? this.duration,
      startTime: clearStart ? null : (startTime ?? this.startTime),
    );
  }
}
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

Uuid uuid = const Uuid();



@freezed
abstract class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    String? desc,
  required DateTime updatedAt,
    required String tag,
    required int priority,
    @Default(false) bool completed,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  factory Task.add({
    required String title,
    String? desc,
    required DateTime updatedAt,
    required String tag,
    required int priority,
  }) {
    return Task(
      id: uuid.v4(),
      title: title,
      desc: desc,
      updatedAt: updatedAt,
      tag: tag,
      priority: priority,
    );
  }
}

enum Filter { all, today, active, completed}
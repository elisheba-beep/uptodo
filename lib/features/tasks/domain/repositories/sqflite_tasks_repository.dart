import 'dart:convert';

import 'package:flutter_riverpod/experimental/persist.dart';
import 'package:riverpod_sqflite/riverpod_sqflite.dart';
import 'package:uptodo/features/tasks/domain/models/task_model.dart';
import 'package:uptodo/features/tasks/domain/repositories/tasks_repository.dart';

class SqfliteTasksRepository extends TasksRepository {
  SqfliteTasksRepository(this._taskStorage);
  final JsonSqFliteStorage _taskStorage;

  static const _key = 'tasks';

  static const _options = StorageOptions(
    cacheTime: StorageCacheTime.unsafe_forever,
  );

  Future<List<Task>> readAll() async {
    final persisted = await _taskStorage.read(_key);
    if (persisted == null) return [];
    final decoded = jsonDecode(persisted.data) as List;
    return [
      for (final task in decoded) Task.fromJson(task as Map<String, dynamic>),
    ];
  }

  Future<void> writeAll(List<Task> tasks) {
    final encoded = jsonEncode([for (final task in tasks) task.toJson()]);
    return _taskStorage.write(_key, encoded, _options);
  }

  @override
  Future<List<Task>> getTasks() => readAll();

  @override
  Future<void> addTask({required Task task}) async {
    final tasks = await readAll();
    await writeAll([...tasks, task]);
  }

  @override
  Future<void> editTask({
    required String id,
    String? title,
    String? desc,
    DateTime? updatedAt,
    String? tag,
    int? priority,
  }) async {
    final tasks = await readAll();
    await writeAll([
      for (final task in tasks)
        if (task.id == id)
          task.copyWith(
            title: title ?? task.title,
            desc: desc ?? task.desc,
            updatedAt: updatedAt ?? task.updatedAt,
            tag: tag ?? task.tag,
            priority: priority ?? task.priority,
          )
        else
          task,
    ]);
  }

  @override
  Future<void> toggleTask({required String id}) async {
    final tasks = await readAll();
    await writeAll([
      for (final task in tasks)
        (task.id == id) ? task.copyWith(completed: !task.completed) : task,
    ]);
  }

  @override
  Future<void> removeTask({required String id}) async {
    final tasks = await readAll();
    await writeAll([
      for (final task in tasks)
        if (task.id != id) task,
    ]);
  }
}

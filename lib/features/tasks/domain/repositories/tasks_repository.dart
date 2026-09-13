
import 'package:uptodo/features/tasks/domain/models/task_model.dart';

abstract class TasksRepository {
  Future<List<Task>> getTasks();
  Future<void> addTask({required Task task});
  Future<void> editTask({required String id, 
  String? title,
    String? desc,
    DateTime? updatedAt,
    String? tag,
    int? priority,
  });
  Future<void> toggleTask({required String id});
  Future<void> removeTask({required String id});
}
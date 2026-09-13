import 'package:uptodo/features/tasks/domain/models/task_model.dart';
import 'package:uptodo/features/tasks/domain/repositories/tasks_repository.dart';

final initialTasks = [
  {
    'id': '1',
    'title': 'Do Math Homework',
    'desc': 'Do chapter 2 to 5 for next week',
    'updatedAt': DateTime(2026, 01, 01, 16, 45).toIso8601String(),
    'tag': 'University',
    'priority': 1,
    'completed': false,
  },
  {
    'id': '2',
    'title': 'Take out dogs',
    'updatedAt': DateTime(2026, 01, 03, 18, 20).toIso8601String(),
    'tag': 'Home',
    'priority': 2,
    'completed': false,
  },
  {
    'id': '3',
    'title': 'Business meeting with CEO',
    'updatedAt': DateTime(2026, 01, 05, 20, 15).toIso8601String(),
    'tag': 'Work',
    'priority': 3,
    'completed': false,
  },
];

const int kDelayDuration = 1;

class FakeTasksRepository extends TasksRepository {
 List<Map<String, dynamic>> fakeTasks = initialTasks;

  Future<void> waitSeconds() {
    return Future.delayed(const Duration(seconds: kDelayDuration));
  }

  @override
  Future<List<Task>> getTasks() async {
      await waitSeconds();
    try {
      return [for (final task in fakeTasks) Task.fromJson(task)];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addTask({required Task task}) async {
    await waitSeconds();
    try {
      fakeTasks = [...fakeTasks, task.toJson()];
    } catch (e) {
      rethrow;
    }
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
    await waitSeconds();
    try {
      fakeTasks = [
        for (final task in fakeTasks)
          if (task['id'] == id)
           {
              'id': id,
              'title': title ?? task['title'], 
              'desc': desc ?? task['desc'],
              'updatedAt': updatedAt?.toIso8601String() ?? task['updatedAt'], 
              'tag': tag ?? task['tag'],
              'priority': priority ?? task['priority'],
              'completed': task['completed'],
            }
          else
            task,
      ];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> toggleTask({required String id}) async {
    await waitSeconds();
    try {
      fakeTasks = [
        for (final task in fakeTasks)
          if (task['id'] == id)
            {
              'id': id,
              'title': task['title'],
              'desc': task['desc'],
              'updatedAt': task['updatedAt'],
              'tag': task['tag'],
              'priority': task['priority'],
              'completed': !task['completed'],
            }
          else
            task,
      ];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeTask({required String id}) async {
    await waitSeconds();
    try {
      fakeTasks = [
        for (final task in fakeTasks)
          if (task['id'] != id) task,
      ];
    } catch (e) {
      rethrow;
    }
  }
}

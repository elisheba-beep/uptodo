import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uptodo/core/models/task_model.dart';

part 'task_list_provider.g.dart';

@riverpod
class TaskList extends _$TaskList {
  @override
  List<Task> build() {
    return [
      Task(
        id: '1',
        title: 'Do Math Homework',
        desc: 'Do chapter 2 to 5 for next week',
        updatedAt: DateTime(2026, 01, 01, 16, 45),
        tag: 'University',
        priority: 1,
      ),
      Task(
        id: '2',
        title: 'Take out dogs',
        updatedAt: DateTime(2026, 01, 03, 18, 20),
        tag: 'Home',
        priority: 2,
      ),
      Task(
        id: '3',
        title: 'Business meeting with CEO',
        updatedAt: DateTime(2026, 01, 05, 20, 15),
        tag: 'Work',
        priority: 3,
      ),
    ];
  }

  void addTask(
    String title,
    String? desc,
    DateTime updatedAt,
    String tag,
    int priority,
  ) {
    state = [
      ...state,
      Task.add(
        title: title,
        desc: desc,
        updatedAt: updatedAt,
        tag: tag,
        priority: priority,
      ),
    ];
  }

  void editTask(
    String id,
    String? title,
    String? desc,
    DateTime? updatedAt,
    String? tag,
    int? priority,
  ) {
    state = [
      for (final task in state)
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
    ];
  }

  void toggleTask(String id) {
    state = [
      for (final task in state)
        if (task.id == id) task.copyWith(completed: !task.completed) else task,
    ];
  }

  void deleteTask(String id) {
    state = [
      for (final task in state)
        if (task.id != id) task,
    ];
  }
}

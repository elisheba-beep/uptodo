import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uptodo/features/tasks/domain/models/task_model.dart';
import 'package:uptodo/features/tasks/domain/repositories/providers/tasks_repository_provider.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_list/task_list_state.dart';

part 'task_list_provider.g.dart';

@riverpod
class TaskList extends _$TaskList {
  @override
  TaskListState build() {
    return TaskListState.initial();
  }

  Future<void> getTasks() async {
    state = state.copyWith(status: TaskListStatus.loading);

    try {
      final tasks = await ref.read(tasksRepositoryProvider).getTasks();
      state = state.copyWith(status: TaskListStatus.success, tasks: tasks);
    } catch (e) {
      state = state.copyWith(
        status: TaskListStatus.failure,
        error: e.toString(),
      );
    }
  }

  Future<void> addTask(
    String title,
    String? desc,
    DateTime updatedAt,
    String tag,
    int priority,
  ) async {
    state = state.copyWith(status: TaskListStatus.loading);

    try {
      final newTask = Task.add(
        title: title,
        updatedAt: updatedAt,
        tag: tag,
        priority: priority,
      );
      await ref.read(tasksRepositoryProvider).addTask(task: newTask);

      state = state.copyWith(
        status: TaskListStatus.success,
        tasks: [...state.tasks, newTask],
      );
    } catch (e) {
      state = state.copyWith(
        status: TaskListStatus.failure,
        error: e.toString(),
      );
    }
  }

  Future<void> editTask(
    String id,
    String? title,
    String? desc,
    DateTime? updatedAt,
    String? tag,
    int? priority,
  ) async {
    state = state.copyWith(status: TaskListStatus.loading);

    try {
      await ref
          .read(tasksRepositoryProvider)
          .editTask(
            id: id,
            title: title,
            updatedAt: updatedAt,
            tag: tag,
            priority: priority,
          );
      state = state.copyWith(
        status: TaskListStatus.success,
        tasks: [
          for (final task in state.tasks)
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
        ],
      );
    } catch (e) {
      state = state.copyWith(
        status: TaskListStatus.failure,
        error: e.toString(),
      );
    }
  }

  Future<void> toggleTask(String id) async {
    state = state.copyWith(status: TaskListStatus.loading);

    try {
      await ref.read(tasksRepositoryProvider).toggleTask(id: id);
      state = state.copyWith(
        status: TaskListStatus.success,
        tasks: [
          for (final task in state.tasks)
            if (task.id == id)
              task.copyWith(completed: !task.completed)
            else
              task,
        ],
      );
    } catch (e) {
      state = state.copyWith(
        status: TaskListStatus.failure,
        error: e.toString(),
      );
    }
  }

  Future<void> deleteTask(String id) async {
    state = state.copyWith(status: TaskListStatus.loading);

    try {
      await ref.read(tasksRepositoryProvider).removeTask(id: id);

      state = state.copyWith(
        status: TaskListStatus.success,
        tasks: [
          for (final task in state.tasks)
            if (task.id != id) task,
        ],
      );
    } catch (e) {
      state = state.copyWith(
        status: TaskListStatus.failure,
        error: e.toString(),
      );
    }
  }
}

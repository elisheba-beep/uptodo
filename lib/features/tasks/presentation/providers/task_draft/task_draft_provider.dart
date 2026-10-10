import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uptodo/features/tasks/domain/models/task_model.dart';
import 'package:uptodo/features/tasks/presentation/providers/task_list/task_list_provider.dart';

part 'task_draft_provider.g.dart';

@Riverpod(keepAlive:true)
class TaskDraft extends _$TaskDraft {
  @override
  Task build() {
    return _initialTaskDraft();
  }

  Task _initialTaskDraft() {
    return Task(
      id: '',
      title: '',
      desc: null,
      updatedAt: DateTime.now(),
      tag: '',
      priority: 1,
    );
  }

  void startCreatingTask() => state = _initialTaskDraft();

  void startUpdatingTask(String currentTaskId) {
    final taskListState = ref.read(taskListProvider);
    final currentTask = taskListState.tasks.firstWhere((task) => task.id == currentTaskId);

    state = currentTask;
  }

  void updateTitle(String title) => state = state.copyWith(title: title);
  void updateDesc(String? desc) => state = state.copyWith(desc: desc);
  void updateDateTime(DateTime dateTime) =>
      state = state.copyWith(updatedAt: dateTime);
  void updateTag(String tag) => state = state.copyWith(tag: tag);
  void updatePriority(int priority) =>
      state = state.copyWith(priority: priority);

  bool get isValid => state.title.trim().isNotEmpty;
}



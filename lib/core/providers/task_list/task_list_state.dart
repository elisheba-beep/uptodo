import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uptodo/core/models/task_model.dart';

part 'task_list_state.freezed.dart';

enum TaskListStatus { initial, loading, success, failure }

@freezed
abstract class TaskListState with _$TaskListState {
  const factory TaskListState({
    required TaskListStatus status,
    required List<Task> tasks,
    @Default('') String error,
  }) = _TaskListState;

  factory TaskListState.initial() {
    return const TaskListState(status: TaskListStatus.initial, tasks: []);
  }
}

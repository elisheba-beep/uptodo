import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uptodo/core/providers/task_list/task_list_provider.dart';

part 'active_task_count_provider.g.dart';

@riverpod
int activeTaskCount(Ref ref) {
  final tasks = ref.watch(taskListProvider);
  return tasks.where((task) => !task.completed).toList().length;
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uptodo/core/models/task_model.dart';
import 'package:uptodo/core/providers/task_list/task_list_provider.dart';
import 'package:uptodo/core/providers/task_search/task_search_provider.dart';

part 'filtered_tasks_provider.g.dart';

@riverpod
List<Task> filteredTasks(Ref ref, Filter filter) {
  final tasks = ref.watch(taskListProvider);
  final search = ref.watch(taskSearchProvider);

  List<Task> tempTasks;

  final now = DateTime.now();
  final startOfToday = DateTime(now.year, now.month, now.day);
  final startOfTomorrow = startOfToday.add(Duration(days: 1));
  tempTasks = switch (filter) {
    Filter.today => tasks.where((task) {
      final date = task.updatedAt;
      return (date.isAfter(startOfToday) ||
              date.isAtSameMomentAs(startOfToday)) &&
          date.isBefore(startOfTomorrow);
    }).toList(),
    Filter.completed => tasks.where((task) => task.completed).toList(),
    Filter.all => tasks,
  };
  if (search.isNotEmpty) {
    tempTasks = tempTasks
        .where(
          (task) => task.title.toLowerCase().contains(search.toLowerCase()),
        )
        .toList();
  }
  return tempTasks;
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uptodo/core/models/task_model.dart';

part 'task_filter_provider.g.dart';

@riverpod
class TaskFilter extends _$TaskFilter {
  @override
  Filter build() {
    return Filter.all;
  }

  void changeFilter(Filter newFilter) {
    state = newFilter;
  }
}

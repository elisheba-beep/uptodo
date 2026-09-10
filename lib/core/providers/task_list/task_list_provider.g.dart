// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TaskList)
final taskListProvider = TaskListProvider._();

final class TaskListProvider extends $NotifierProvider<TaskList, List<Task>> {
  TaskListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskListHash();

  @$internal
  @override
  TaskList create() => TaskList();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Task> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Task>>(value),
    );
  }
}

String _$taskListHash() => r'edf089ced69d0742286e2a846a493c66b46622d8';

abstract class _$TaskList extends $Notifier<List<Task>> {
  List<Task> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Task>, List<Task>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Task>, List<Task>>,
              List<Task>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

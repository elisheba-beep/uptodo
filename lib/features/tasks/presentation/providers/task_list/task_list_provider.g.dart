// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TaskList)
final taskListProvider = TaskListProvider._();

final class TaskListProvider
    extends $NotifierProvider<TaskList, TaskListState> {
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
  Override overrideWithValue(TaskListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskListState>(value),
    );
  }
}

String _$taskListHash() => r'31deb0435d578abd8e99b447367f82f07785ecf5';

abstract class _$TaskList extends $Notifier<TaskListState> {
  TaskListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TaskListState, TaskListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TaskListState, TaskListState>,
              TaskListState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

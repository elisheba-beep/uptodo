// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_draft_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TaskDraft)
final taskDraftProvider = TaskDraftProvider._();

final class TaskDraftProvider extends $NotifierProvider<TaskDraft, Task> {
  TaskDraftProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskDraftProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskDraftHash();

  @$internal
  @override
  TaskDraft create() => TaskDraft();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Task value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Task>(value),
    );
  }
}

String _$taskDraftHash() => r'2b272524a442a3f89cb6b79d45bc43e623bebc19';

abstract class _$TaskDraft extends $Notifier<Task> {
  Task build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Task, Task>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Task, Task>,
              Task,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

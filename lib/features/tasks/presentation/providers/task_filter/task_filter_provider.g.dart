// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TaskFilter)
final taskFilterProvider = TaskFilterProvider._();

final class TaskFilterProvider extends $NotifierProvider<TaskFilter, Filter> {
  TaskFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskFilterHash();

  @$internal
  @override
  TaskFilter create() => TaskFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Filter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Filter>(value),
    );
  }
}

String _$taskFilterHash() => r'8e15f8c68cd2a7f63fec71226091ebb67613213c';

abstract class _$TaskFilter extends $Notifier<Filter> {
  Filter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Filter, Filter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Filter, Filter>,
              Filter,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

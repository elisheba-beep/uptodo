// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TaskSearch)
final taskSearchProvider = TaskSearchProvider._();

final class TaskSearchProvider extends $NotifierProvider<TaskSearch, String> {
  TaskSearchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskSearchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskSearchHash();

  @$internal
  @override
  TaskSearch create() => TaskSearch();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$taskSearchHash() => r'1e9625d49be140f1af5124aec50cfe07e30ec9ab';

abstract class _$TaskSearch extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

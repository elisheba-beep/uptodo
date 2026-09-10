// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filtered_tasks_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(filteredTasks)
final filteredTasksProvider = FilteredTasksFamily._();

final class FilteredTasksProvider
    extends $FunctionalProvider<List<Task>, List<Task>, List<Task>>
    with $Provider<List<Task>> {
  FilteredTasksProvider._({
    required FilteredTasksFamily super.from,
    required Filter super.argument,
  }) : super(
         retry: null,
         name: r'filteredTasksProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$filteredTasksHash();

  @override
  String toString() {
    return r'filteredTasksProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<Task>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Task> create(Ref ref) {
    final argument = this.argument as Filter;
    return filteredTasks(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Task> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Task>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredTasksProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$filteredTasksHash() => r'fa78e63d13531a652a6c5be42a1673f3abd05b1b';

final class FilteredTasksFamily extends $Family
    with $FunctionalFamilyOverride<List<Task>, Filter> {
  FilteredTasksFamily._()
    : super(
        retry: null,
        name: r'filteredTasksProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FilteredTasksProvider call(Filter filter) =>
      FilteredTasksProvider._(argument: filter, from: this);

  @override
  String toString() => r'filteredTasksProvider';
}

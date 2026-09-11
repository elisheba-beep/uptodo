// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_card_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(taskCard)
final taskCardProvider = TaskCardProvider._();

final class TaskCardProvider extends $FunctionalProvider<Task, Task, Task>
    with $Provider<Task> {
  TaskCardProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskCardProvider',
        isAutoDispose: true,
        dependencies: <ProviderOrFamily>[],
        $allTransitiveDependencies: <ProviderOrFamily>[],
      );

  @override
  String debugGetCreateSourceHash() => _$taskCardHash();

  @$internal
  @override
  $ProviderElement<Task> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Task create(Ref ref) {
    return taskCard(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Task value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Task>(value),
    );
  }
}

String _$taskCardHash() => r'58d831b3a00c09e33ef866680ab049a5d9f4f257';

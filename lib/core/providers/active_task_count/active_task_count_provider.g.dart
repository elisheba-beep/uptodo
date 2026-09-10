// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_task_count_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activeTaskCount)
final activeTaskCountProvider = ActiveTaskCountProvider._();

final class ActiveTaskCountProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  ActiveTaskCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeTaskCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeTaskCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return activeTaskCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$activeTaskCountHash() => r'2179f1890f951cc10915fe76d07e1696bdd4f536';

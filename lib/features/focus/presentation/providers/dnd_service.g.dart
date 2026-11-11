// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dnd_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dndService)
final dndServiceProvider = DndServiceProvider._();

final class DndServiceProvider
    extends $FunctionalProvider<DndService, DndService, DndService>
    with $Provider<DndService> {
  DndServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dndServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dndServiceHash();

  @$internal
  @override
  $ProviderElement<DndService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DndService create(Ref ref) {
    return dndService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DndService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DndService>(value),
    );
  }
}

String _$dndServiceHash() => r'785b26dfb11be15d7e4bafdaa9e87d2ce00a6a51';

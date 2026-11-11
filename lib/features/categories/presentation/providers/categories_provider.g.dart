// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Categories)
final categoriesProvider = CategoriesProvider._();

final class CategoriesProvider
    extends $NotifierProvider<Categories, List<ChooseCategory>> {
  CategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesHash();

  @$internal
  @override
  Categories create() => Categories();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ChooseCategory> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ChooseCategory>>(value),
    );
  }
}

String _$categoriesHash() => r'ee518805f699f67ff1e6a667fc6ea0cf957948a8';

abstract class _$Categories extends $Notifier<List<ChooseCategory>> {
  List<ChooseCategory> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<ChooseCategory>, List<ChooseCategory>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<ChooseCategory>, List<ChooseCategory>>,
              List<ChooseCategory>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

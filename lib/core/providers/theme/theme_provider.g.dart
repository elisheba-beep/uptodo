// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Theme)
final themeProvider = ThemeProvider._();

final class ThemeProvider extends $NotifierProvider<Theme, AppTheme> {
  ThemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeHash();

  @$internal
  @override
  Theme create() => Theme();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppTheme value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppTheme>(value),
    );
  }
}

String _$themeHash() => r'398211247e9731ff82e55600669416aee3c1eeb7';

abstract class _$Theme extends $Notifier<AppTheme> {
  AppTheme build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppTheme, AppTheme>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppTheme, AppTheme>,
              AppTheme,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

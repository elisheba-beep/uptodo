// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_completed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OnboardingCompletedNotifier)
final onboardingCompletedProvider = OnboardingCompletedNotifierProvider._();

final class OnboardingCompletedNotifierProvider
    extends $NotifierProvider<OnboardingCompletedNotifier, bool> {
  OnboardingCompletedNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingCompletedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingCompletedNotifierHash();

  @$internal
  @override
  OnboardingCompletedNotifier create() => OnboardingCompletedNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$onboardingCompletedNotifierHash() =>
    r'1f95d2783363591ddb029f75365cae99a5586f04';

abstract class _$OnboardingCompletedNotifier extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

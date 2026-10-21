// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Signup)
final signupProvider = SignupProvider._();

final class SignupProvider extends $AsyncNotifierProvider<Signup, void> {
  SignupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signupHash();

  @$internal
  @override
  Signup create() => Signup();
}

String _$signupHash() => r'91a5b077f0890f38b3eebbba30a01ec83fc7d442';

abstract class _$Signup extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uptodo/features/authentication/domain/repositories/auth_repository_provider.dart';

part 'signin_provider.g.dart';

@riverpod
class Signin extends _$Signin {
  Object? _key;
  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() => print('[signin provider] disposed'));
  }

  FutureOr<void> signin({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading<void>();

    final key = _key;

    final newState = await AsyncValue.guard<void>(
      () => ref
          .read(authRepositoryProvider)
          .signIn(email: email, password: password),
    );

    if (!ref.mounted || key == _key) {
      state = newState;
    }
  }
}

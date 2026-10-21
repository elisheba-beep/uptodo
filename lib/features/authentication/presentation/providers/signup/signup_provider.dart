import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uptodo/features/authentication/domain/repositories/auth_repository_provider.dart';

part 'signup_provider.g.dart';

@riverpod
class Signup extends _$Signup {
  Object? _key;
  @override
  FutureOr<void> build() {
    _key = Object();
    ref.onDispose(() => print('[signup provider] disposed'));
  }

  FutureOr<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading<void>();
    final key = _key;

    final newState = await AsyncValue.guard<void>(
      () => ref
          .read(authRepositoryProvider)
          .signUp(name: name, email: email, password: password),
    );

    if (!ref.mounted || key == _key) {
      state = newState;
    }
  }
}

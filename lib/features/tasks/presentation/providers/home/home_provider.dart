import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uptodo/features/authentication/data/models/app_user.dart';
import 'package:uptodo/features/profile/domain/repositories/profile_repository_provider.dart';

part 'home_provider.g.dart';

@riverpod
FutureOr<AppUser> profile(Ref ref, String uid) {
  return ref.watch(profileReposirotyProvider).getProfile(uid: uid);
}

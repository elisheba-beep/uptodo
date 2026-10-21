import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uptodo/features/profile/domain/repositories/profile_repository.dart';

part 'profile_repository_provider.g.dart';

@riverpod
ProfileRepository profileReposiroty (Ref ref) {
 return ProfileRepository() ;
}
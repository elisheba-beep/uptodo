import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uptodo/core/constant/firebase_constants.dart';
import 'package:uptodo/features/authentication/domain/repositories/auth_repository.dart';

part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository (Ref ref) {
  return AuthRepository();
}

@riverpod
Stream<User?> authStateStream (Ref ref) {
  return fbAuth.authStateChanges();
}
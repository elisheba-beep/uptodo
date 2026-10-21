// ignore_for_file: strict_top_level_inference

import 'package:firebase_auth/firebase_auth.dart';
import 'package:uptodo/features/authentication/data/models/custom_error.dart';

CustomError handleException(e) {
  try {
    throw e;
  } on FirebaseAuthException catch (e) {
    return CustomError(
      code: e.code,
      message: e.message ?? 'Invalid credentials',
      plugin: e.plugin,
    );
  } on FirebaseException catch (e) {
    return CustomError(
      code: e.code,
      message: e.message ?? 'Firebase Error',
      plugin: e.plugin,
    );
  } catch (e) {
    return CustomError(
      code: 'Exception',
      message: e.toString(),
      plugin: 'Unknown Error',
    );
  }
}

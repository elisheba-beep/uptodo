import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uptodo/core/constant/firebase_constants.dart';
import 'package:uptodo/features/authentication/data/models/app_user.dart';
import 'package:uptodo/features/authentication/domain/repositories/handle_exception.dart';

class ProfileRepository {
  final _picker = ImagePicker();

  Future<AppUser> getProfile({required String uid}) async {
    try {
      final DocumentSnapshot appUserDoc = await usersCollection.doc(uid).get();

      if (appUserDoc.exists) {
        final appUser = AppUser.fromDoc(appUserDoc);
        return appUser;
      }
      throw 'User not found';
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      return await _picker.pickImage(
        source: source,
        imageQuality: 70,
        maxWidth: 256,
        maxHeight: 256,
      );
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> uploadProfilePicture({
    required XFile file,
    required String uid,
  }) async {
    try {
      final bytes = await file.readAsBytes();
      if (bytes.lengthInBytes > 200 * 1024) {
        throw 'Image is too large, please pick a smaller one';
      }
      await usersCollection.doc(uid).update({
        'profilePic': base64Encode(bytes),
      });
    } catch (e) {
      throw handleException(e);
    }
  }
}

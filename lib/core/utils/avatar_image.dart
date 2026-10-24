import 'dart:convert';
import 'package:flutter/material.dart';

ImageProvider avatarImage(String? profilePic) {
  if (profilePic != null && profilePic.isNotEmpty) {
    try {
      return MemoryImage(base64Decode(profilePic));
    } catch (_) {}
  }
  return const AssetImage('assets/images/profile_picture.png');
}
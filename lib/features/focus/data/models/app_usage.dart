import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_usage.freezed.dart';

@freezed
abstract class AppUsage with _$AppUsage {
  const factory AppUsage(
     String name,
     String usage,
     IconData icon,
     Color color,
  ) = _AppUsage;

 
}

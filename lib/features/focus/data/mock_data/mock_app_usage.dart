import 'package:uptodo/features/focus/data/models/app_usage.dart';
import 'package:flutter/material.dart';

const mockApps = [
  AppUsage(
    'Instagram',
    'You spent 4h on Instagram today',
    Icons.camera_alt,
    Colors.pink,
  ),
  AppUsage(
    'Twitter',
    'You spent 3h on Twitter today',
    Icons.alternate_email,
    Colors.lightBlue,
  ),
  AppUsage(
    'Facebook',
    'You spent 1h on Facebook today',
    Icons.facebook,
    Colors.blue,
  ),
  AppUsage(
    'Telegram',
    'You spent 30m on Telegram today',
    Icons.send,
    Colors.cyan,
  ),
  AppUsage('Gmail', 'You spent 45m on Gmail today', Icons.mail, Colors.red),
];

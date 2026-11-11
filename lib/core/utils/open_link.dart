import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens [url] in the browser / store app. Shows a snackbar if it fails.
Future<void> openLink(BuildContext context, String url) async {

  final messenger = ScaffoldMessenger.of(context);
  const failed = SnackBar(content: Text('Could not open the link'));

  try {
    final ok = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!ok) messenger.showSnackBar(failed);
  } catch (_) {
    messenger.showSnackBar(failed);
  }
}
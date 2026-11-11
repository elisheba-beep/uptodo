import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/features/focus/presentation/providers/dnd_service.dart';
import 'package:uptodo/features/focus/presentation/providers/focus_notifier.dart';
import 'package:uptodo/features/focus/presentation/providers/focus_session.dart';
import 'package:uptodo/features/focus/presentation/widgets/duration_picker.dart';
import 'package:uptodo/features/profile/presentation/widgets/settings_page_scaffold.dart';

class AppSettingsScreen extends ConsumerStatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  ConsumerState<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends ConsumerState<AppSettingsScreen>
    with WidgetsBindingObserver {
  bool _silenceEnabled = true;
  bool _hasAccess = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // The user may grant DND access in system settings and come back here.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refresh();
  }

  Future<void> _refresh() async {
    final dnd = ref.read(dndServiceProvider);
    final enabled = await dnd.isEnabledPref();
    final access = await dnd.hasAccess();
    if (!mounted) return;
    setState(() {
      _silenceEnabled = enabled;
      _hasAccess = access;
    });
  }

  Future<void> _toggleSilence(bool value) async {
    setState(() => _silenceEnabled = value);
    await ref.read(dndServiceProvider).setEnabledPref(value);
  }

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    if (h == 0) return '$m min';
    if (m == 0) return '${h}h';
    return '${h}h ${m}m';
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(focusProvider);
    final running = session.status == FocusStatus.running;
    final dnd = ref.read(dndServiceProvider);

    return SettingsPageScaffold(
      title: 'App Settings',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionLabel('Focus'),
          _SettingsRow(
            icon: Icons.timer_outlined,
            title: 'Default focus duration',
            trailing: _ValueChip(_formatDuration(session.duration)),
            onTap: running ? null : () => showDurationPicker(context, ref),
          ),
          if (running)
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                'You can change this after your current session ends.',
                style: TextStyle(fontSize: 12, color: AppColors.mediumGray),
              ),
            ),
          if (dnd.isSupported) ...[
            24.heightBox,
            const _SectionLabel('Notifications'),
            _SettingsRow(
              icon: Icons.notifications_off_outlined,
              title: 'Silence notifications while focusing',
              subtitle: 'Uses Do Not Disturb during a focus session',
              trailing: Switch(
                value: _silenceEnabled,
                onChanged: _toggleSilence,
                thumbColor: const WidgetStatePropertyAll(AppColors.white),
                trackColor: WidgetStateProperty.resolveWith(
                      (states) => states.contains(WidgetState.selected)
                      ? AppColors.purple
                      : AppColors.mediumDarkGray,
                ),
                trackOutlineColor: const WidgetStatePropertyAll(
                  Colors.transparent,
                ),
              ),
              onTap: () => _toggleSilence(!_silenceEnabled),
            ),
            _SettingsRow(
              icon: Icons.do_not_disturb_on_outlined,
              title: 'Do Not Disturb access',
              trailing: _ValueChip(_hasAccess ? 'Allowed' : 'Not allowed'),
              onTap: dnd.openAccessSettings,
            ),
          ],
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.trailing,
    this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      tileColor: Colors.transparent,
      onTap: onTap,
      leading: Icon(icon, size: 24, color: AppColors.white),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
        subtitle!,
        style: const TextStyle(fontSize: 12, color: AppColors.mediumGray),
      ),
      trailing: trailing,
    );
  }
}

class _ValueChip extends StatelessWidget {
  const _ValueChip(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.popUpBackgroundColor,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          letterSpacing: -0.32,
          color: AppColors.white,
        ),
      ),
    );
  }
}
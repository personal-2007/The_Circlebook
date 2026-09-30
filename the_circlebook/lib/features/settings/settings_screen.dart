import 'package:flutter/material.dart';

import '../../services/storage_service.dart';
import '../../theme/app_theme.dart';
import 'account_settings_view.dart';
import 'appearance_settings_view.dart';
import 'notifications_settings_view.dart';
import 'personalization_settings_view.dart';
import 'privacy_settings_view.dart';
import 'security_settings_view.dart';
import 'support_settings_view.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    required this.onThemeModeChanged,
    required this.themeMode,
    this.onAccessibilityChanged,
    super.key,
  });

  final ValueChanged<ThemeMode> onThemeModeChanged;
  final ThemeMode themeMode;
  final VoidCallback? onAccessibilityChanged;

  void _showDeactivateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Deactivate Account?'),
        content: const Text(
          'Deactivating temporarily hides your profile, circles, and posts. You can reactivate at any time by simply logging back in.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton.tonal(
            onPressed: () async {
              Navigator.pop(ctx);
              await StorageService.logout();
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (r) => false);
              }
            },
            child: const Text('Deactivate'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Permanently Delete Account?'),
        content: const Text(
          'This action is irreversible. All your posts, direct messages, circle memberships, and personal data will be completely erased in compliance with privacy regulations.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppTheme.danger),
            onPressed: () async {
              Navigator.pop(ctx);
              await StorageService.logout();
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (r) => false);
              }
            },
            child: const Text('Permanently Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          // 1. Account Section
          _SettingsSectionHeader(title: 'Account', icon: Icons.person_outline_rounded),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.badge_outlined,
                iconColor: AppTheme.primary,
                title: 'Account Information',
                subtitle: 'Username, email, phone, password, account status',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AccountSettingsView()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // 2. Privacy Section
          _SettingsSectionHeader(title: 'Privacy', icon: Icons.privacy_tip_outlined),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.shield_outlined,
                iconColor: AppTheme.purple,
                title: 'Privacy Controls',
                subtitle: 'Profile visibility, post visibility, messaging, blocking',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PrivacySettingsView()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // 3. Security Section
          _SettingsSectionHeader(title: 'Security', icon: Icons.security_rounded),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.lock_outline_rounded,
                iconColor: AppTheme.secondary,
                title: 'Security & Authentication',
                subtitle: 'Two-factor auth, login sessions, devices, alerts',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SecuritySettingsView()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // 4. Notifications Section
          _SettingsSectionHeader(title: 'Notifications', icon: Icons.notifications_none_rounded),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.notifications_active_outlined,
                iconColor: AppTheme.accent,
                title: 'Notification Preferences',
                subtitle: 'Push, email, message, social, recommendation alerts',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NotificationsSettingsView()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // 5. Appearance Section
          _SettingsSectionHeader(title: 'Appearance', icon: Icons.palette_outlined),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.brightness_6_outlined,
                iconColor: AppTheme.primary,
                title: 'Theme & Accessibility',
                subtitle: 'Light, dark, system, text scaling, reduced motion',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AppearanceSettingsView(
                      onThemeModeChanged: onThemeModeChanged,
                      themeMode: themeMode,
                      onAccessibilityChanged: onAccessibilityChanged,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // 6. Data & Personalization Section
          _SettingsSectionHeader(title: 'Data & Personalization', icon: Icons.tune_rounded),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.tune_rounded,
                iconColor: AppTheme.purple,
                title: 'Personalization & Algorithms',
                subtitle: 'Data export, activity logs, user-controlled feed ranking',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PersonalizationSettingsView()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // 7. Support Section
          _SettingsSectionHeader(title: 'Support', icon: Icons.help_outline_rounded),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.help_outline_rounded,
                iconColor: AppTheme.textMuted,
                title: 'Help, Guidelines & Policies',
                subtitle: 'Help center, report a problem, community guidelines, terms',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SupportSettingsView()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // 8. Account Exit Section
          _SettingsSectionHeader(title: 'Account Exit', icon: Icons.power_settings_new_rounded),
          _SettingsCard(
            children: [
              _SettingsTile(
                icon: Icons.logout_rounded,
                iconColor: AppTheme.danger,
                title: 'Log Out',
                subtitle: 'Sign out of this device',
                textColor: AppTheme.danger,
                onTap: () async {
                  await StorageService.logout();
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (r) => false);
                  }
                },
              ),
              const Divider(height: 1),
              _SettingsTile(
                icon: Icons.pause_circle_outline_rounded,
                iconColor: AppTheme.warning,
                title: 'Deactivate Account',
                subtitle: 'Temporarily hide your profile and circles',
                onTap: () => _showDeactivateDialog(context),
              ),
              const Divider(height: 1),
              _SettingsTile(
                icon: Icons.delete_forever_rounded,
                iconColor: AppTheme.danger,
                title: 'Delete Account',
                subtitle: 'Permanently remove your account and all associated data',
                textColor: AppTheme.danger,
                onTap: () => _showDeleteAccountDialog(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsSectionHeader extends StatelessWidget {
  const _SettingsSectionHeader({required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 4),
      child: Row(
        children: [
          Icon(icon, size: 15, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 6),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.7,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.textColor,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: iconColor.withAlpha(25),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: iconColor, size: 19),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5, color: textColor),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, size: 18),
    );
  }
}

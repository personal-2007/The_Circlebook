import 'package:flutter/material.dart';

import '../../../services/auth_service.dart';
import '../../../services/storage_service.dart';
import '../../../theme/app_theme.dart';

/// Contextual Profile / Account Menu.
/// Provides quick access to:
/// - View Profile
/// - Edit Profile
/// - Settings
/// - Privacy
/// - Help & Support
/// - Log Out
class ProfileMenuSheet extends StatelessWidget {
  const ProfileMenuSheet({
    this.onViewProfile,
    this.onEditProfile,
    super.key,
  });

  final VoidCallback? onViewProfile;
  final VoidCallback? onEditProfile;

  static void show(BuildContext context, {VoidCallback? onViewProfile, VoidCallback? onEditProfile}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => ProfileMenuSheet(
        onViewProfile: onViewProfile,
        onEditProfile: onEditProfile,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = AuthService.currentUser;
    final userName = user?.name ?? 'Member';
    final userHandle = user?.handle ?? '@member';
    final userInitials = userName.trim().isNotEmpty
        ? userName.trim().split(RegExp(r'\s+')).map((p) => p[0]).take(2).join().toUpperCase()
        : 'U';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Text(
                      userInitials,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          userHandle,
                          style: TextStyle(fontSize: 12, color: theme.colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),

            // 1. View Profile
            ListTile(
              leading: const Icon(Icons.person_outline_rounded),
              title: const Text('View Profile'),
              onTap: () {
                Navigator.pop(context);
                onViewProfile?.call();
              },
            ),

            // 2. Edit Profile
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Edit Profile'),
              onTap: () {
                Navigator.pop(context);
                onEditProfile?.call();
              },
            ),

            // 3. Settings
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/app/settings');
              },
            ),

            // 4. Privacy
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('Privacy'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/app/settings/privacy');
              },
            ),

            // 5. Help & Support
            ListTile(
              leading: const Icon(Icons.help_outline_rounded),
              title: const Text('Help & Support'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/app/settings/support');
              },
            ),

            const Divider(),

            // 6. Log Out
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: AppTheme.danger),
              title: const Text('Log Out', style: TextStyle(color: AppTheme.danger, fontWeight: FontWeight.w600)),
              onTap: () async {
                Navigator.pop(context);
                await AuthService.logout();
                await StorageService.logout();
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (r) => false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

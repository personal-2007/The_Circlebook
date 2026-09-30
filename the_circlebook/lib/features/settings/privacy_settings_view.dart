import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class PrivacySettingsView extends StatefulWidget {
  const PrivacySettingsView({super.key});

  @override
  State<PrivacySettingsView> createState() => _PrivacySettingsViewState();
}

class _PrivacySettingsViewState extends State<PrivacySettingsView> {
  String _profileVisibility = 'Circles Only'; // 'Public', 'Circles Only', 'Private'
  String _postVisibility = 'Circles Only';
  String _messagingPrivacy = 'Circles & Mutual Connections';
  bool _allowFriendRequests = true;
  bool _dataPermissionsTelemetry = false;
  final List<String> _blockedUsers = ['usr_blocked_1 (@spammer_99)'];
  final List<String> _restrictedUsers = ['usr_restricted_1 (@distracting_user)'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy & Visibility')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Visibility
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Profile Visibility', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  const SizedBox(height: 6),
                  const Text('Control who can discover and view your full profile credentials and circle membership.'),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: _profileVisibility,
                    decoration: const InputDecoration(labelText: 'Who can see your profile'),
                    items: const [
                      DropdownMenuItem(value: 'Public', child: Text('Public (Everyone)')),
                      DropdownMenuItem(value: 'Circles Only', child: Text('Circles Only (Verified network)')),
                      DropdownMenuItem(value: 'Private', child: Text('Private (Only approved peers)')),
                    ],
                    onChanged: (val) => setState(() => _profileVisibility = val!),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Post Visibility & Messaging Privacy
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.article_outlined, color: AppTheme.primary),
                  title: const Text('Default Post Visibility'),
                  subtitle: Text(_postVisibility),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => SimpleDialog(
                        title: const Text('Default Post Visibility'),
                        children: ['Public', 'Circles Only', 'Close Circles'].map((opt) {
                          return SimpleDialogOption(
                            onPressed: () {
                              setState(() => _postVisibility = opt);
                              Navigator.pop(ctx);
                            },
                            child: Text(opt),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.chat_bubble_outline_rounded, color: AppTheme.primary),
                  title: const Text('Messaging Privacy'),
                  subtitle: Text(_messagingPrivacy),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => SimpleDialog(
                        title: const Text('Who can send direct messages'),
                        children: ['Everyone', 'Circles & Mutual Connections', 'Verified Circles Only'].map((opt) {
                          return SimpleDialogOption(
                            onPressed: () {
                              setState(() => _messagingPrivacy = opt);
                              Navigator.pop(ctx);
                            },
                            child: Text(opt),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.person_add_outlined, color: AppTheme.secondary),
                  title: const Text('Friend / Follow Controls'),
                  subtitle: const Text('Allow new connection requests from recommended peers'),
                  value: _allowFriendRequests,
                  onChanged: (val) => setState(() => _allowFriendRequests = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Blocking & Restricted Users
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.block_rounded, color: AppTheme.danger),
                  title: const Text('Blocking'),
                  subtitle: Text('${_blockedUsers.length} blocked accounts'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Blocked Accounts'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: _blockedUsers.map((u) => ListTile(title: Text(u))).toList(),
                        ),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.shield_outlined, color: AppTheme.warning),
                  title: const Text('Restricted Users'),
                  subtitle: Text('${_restrictedUsers.length} restricted accounts'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Restricted Accounts'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: _restrictedUsers.map((u) => ListTile(title: Text(u))).toList(),
                        ),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Data Permissions
          Card(
            child: SwitchListTile(
              secondary: const Icon(Icons.data_usage_rounded, color: AppTheme.primary),
              title: const Text('Data Permissions & Telemetry'),
              subtitle: const Text('Opt-in to anonymous error reporting to help improve platform stability'),
              value: _dataPermissionsTelemetry,
              onChanged: (val) => setState(() => _dataPermissionsTelemetry = val),
            ),
          ),
        ],
      ),
    );
  }
}

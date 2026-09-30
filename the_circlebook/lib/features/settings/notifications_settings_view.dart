import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class NotificationsSettingsView extends StatefulWidget {
  const NotificationsSettingsView({super.key});

  @override
  State<NotificationsSettingsView> createState() => _NotificationsSettingsViewState();
}

class _NotificationsSettingsViewState extends State<NotificationsSettingsView> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _messageNotifications = true;
  bool _socialNotifications = true;
  bool _recommendationNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Preferences')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.notifications_active_outlined, color: AppTheme.primary),
                  title: const Text('Push Notifications'),
                  subtitle: const Text('Receive instant alerts on your active mobile devices'),
                  value: _pushNotifications,
                  onChanged: (val) => setState(() => _pushNotifications = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.email_outlined, color: AppTheme.secondary),
                  title: const Text('Email Notifications & Digest'),
                  subtitle: const Text('Weekly summary of high-affinity research in your circles'),
                  value: _emailNotifications,
                  onChanged: (val) => setState(() => _emailNotifications = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.chat_bubble_outline_rounded, color: AppTheme.accent),
                  title: const Text('Message Notifications'),
                  subtitle: const Text('Alerts when direct peers or group admins reach out'),
                  value: _messageNotifications,
                  onChanged: (val) => setState(() => _messageNotifications = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.people_outline_rounded, color: AppTheme.purple),
                  title: const Text('Social Notifications'),
                  subtitle: const Text('Likes, comments, shares, and mentions on your posts'),
                  value: _socialNotifications,
                  onChanged: (val) => setState(() => _socialNotifications = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.lightbulb_outline_rounded, color: AppTheme.warning),
                  title: const Text('Recommendation Notifications'),
                  subtitle: const Text('Suggestions for new communities, papers, and peers'),
                  value: _recommendationNotifications,
                  onChanged: (val) => setState(() => _recommendationNotifications = val),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

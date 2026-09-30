import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/circlebook_models.dart';
import '../../theme/app_theme.dart';

class SecuritySettingsView extends StatefulWidget {
  const SecuritySettingsView({super.key});

  @override
  State<SecuritySettingsView> createState() => _SecuritySettingsViewState();
}

class _SecuritySettingsViewState extends State<SecuritySettingsView> {
  bool _twoFactorEnabled = true;
  bool _loginAlertsEnabled = true;
  final List<SessionDevice> _devices = List.from(MockData.activeSessions);

  void _terminateSession(String id) {
    setState(() {
      _devices.removeWhere((d) => d.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Session terminated successfully.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Security & Authentication')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 2FA Card
          Card(
            child: SwitchListTile(
              secondary: const Icon(Icons.security_rounded, color: AppTheme.primary),
              title: const Text('Two-Factor Authentication (2FA)'),
              subtitle: const Text('Require an authentication code when signing in from an unrecognized device'),
              value: _twoFactorEnabled,
              onChanged: (val) => setState(() => _twoFactorEnabled = val),
            ),
          ),
          const SizedBox(height: 12),

          // Login Alerts Card
          Card(
            child: SwitchListTile(
              secondary: const Icon(Icons.notifications_active_outlined, color: AppTheme.secondary),
              title: const Text('Login Alerts'),
              subtitle: const Text('Receive push & email notifications upon new sign-in attempts'),
              value: _loginAlertsEnabled,
              onChanged: (val) => setState(() => _loginAlertsEnabled = val),
            ),
          ),
          const SizedBox(height: 20),

          // Active Sessions & Devices
          Text(
            'Active Login Sessions & Devices',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          ..._devices.map((device) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: Icon(
                  device.platform.contains('Android')
                      ? Icons.phone_android_rounded
                      : device.platform.contains('iPad')
                          ? Icons.tablet_mac_rounded
                          : Icons.laptop_mac_rounded,
                  color: device.isCurrent ? AppTheme.primary : AppTheme.textMuted,
                ),
                title: Row(
                  children: [
                    Expanded(child: Text(device.name, style: const TextStyle(fontWeight: FontWeight.w700))),
                    if (device.isCurrent)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.success.withAlpha(30),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('Current', style: TextStyle(fontSize: 10.5, color: AppTheme.success, fontWeight: FontWeight.w700)),
                      ),
                  ],
                ),
                subtitle: Text('${device.platform} • ${device.location}\n${device.lastActive}', style: const TextStyle(fontSize: 12)),
                trailing: device.isCurrent
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.logout_rounded, size: 18, color: AppTheme.danger),
                        tooltip: 'Revoke device',
                        onPressed: () => _terminateSession(device.id),
                      ),
              ),
            );
          }),
          const SizedBox(height: 16),

          // Security Activity Log
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Recent Security Activity', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  const SizedBox(height: 12),
                  const _ActivityRow(event: 'Password changed successfully', date: 'May 12, 2026'),
                  const Divider(),
                  const _ActivityRow(event: '2FA verification confirmed on Pixel 8', date: 'April 28, 2026'),
                  const Divider(),
                  const _ActivityRow(event: 'New device authorized: ThinkPad X1', date: 'April 10, 2026'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.event, required this.date});
  final String event;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(event, style: const TextStyle(fontSize: 12.5))),
          Text(date, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11)),
        ],
      ),
    );
  }
}

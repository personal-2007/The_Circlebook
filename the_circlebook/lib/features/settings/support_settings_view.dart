import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class SupportSettingsView extends StatelessWidget {
  const SupportSettingsView({super.key});

  void _showInfoModal(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: Text(content)),
        actions: [
          FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Support & Legal')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.help_outline_rounded, color: AppTheme.primary),
                  title: const Text('Help Center & FAQs'),
                  subtitle: const Text('Guides on circle management, privacy, and verified status'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => _showInfoModal(
                    context,
                    'Help Center',
                    'The Circlebook is designed around classical typography, clear boundaries, and peer accountability. If you need assistance with verification, circle governance, or cryptographic tokens, our documentation library is available 24/7.',
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.bug_report_outlined, color: AppTheme.warning),
                  title: const Text('Report a Problem'),
                  subtitle: const Text('Submit a technical feedback ticket to our engineering team'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Report a Problem'),
                        content: const TextField(
                          maxLines: 4,
                          decoration: InputDecoration(hintText: 'Describe what occurred...'),
                        ),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Report submitted.')),
                              );
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.gavel_rounded, color: AppTheme.purple),
                  title: const Text('Community Guidelines'),
                  subtitle: const Text('Standards for mutual respect and academic integrity'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => _showInfoModal(
                    context,
                    'Community Guidelines',
                    'Circlebook members agree to uphold high standards of civility, rigorous attribution of sources, respectful intellectual debate, and absolute zero-tolerance for harassment, automated spam, or coordinated deceptive behavior.',
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.description_outlined, color: AppTheme.textMuted),
                  title: const Text('Terms of Service'),
                  subtitle: const Text('User agreement and platform responsibilities'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => _showInfoModal(
                    context,
                    'Terms of Service',
                    'You own the content and intellectual property you publish to Circlebook. You grant the platform only the licenses strictly necessary to deliver, distribute, and protect your content according to your chosen audience visibility settings.',
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined, color: AppTheme.primary),
                  title: const Text('Privacy Policy'),
                  subtitle: const Text('Our commitments to minimal tracking and data protection'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => _showInfoModal(
                    context,
                    'Privacy Policy',
                    'Circlebook operates on strict data minimization principles. We do not sell your personal data or activity logs to third-party ad networks. All user-controlled recommendation knobs run transparently.',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

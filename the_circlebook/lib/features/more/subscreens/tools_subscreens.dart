import 'package:flutter/material.dart';

import '../../../services/auth_service.dart';
import '../../../theme/app_theme.dart';

/// Creator Tools Screen (under More -> Tools)
class CreatorToolsScreen extends StatelessWidget {
  const CreatorToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Creator Tools')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Content Performance Hub', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  const Text('Manage publications, audience engagement metrics, and circle subscriptions.'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _MetricItem(label: 'Total Impressions', value: '0'),
                      _MetricItem(label: 'Avg Read Time', value: '0m'),
                      _MetricItem(label: 'Circle Growth', value: '0%'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Card(
            child: ListTile(
              leading: const Icon(Icons.newspaper_outlined, color: AppTheme.primary),
              title: const Text('Editorial & Longform Drafts'),
              subtitle: const Text('No drafts in progress'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.workspace_premium_outlined, color: AppTheme.purple),
              title: const Text('Circle Subscriptions & Badges'),
              subtitle: const Text('Manage contributor privileges'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

/// Professional Tools Screen (under More -> Tools)
class ProfessionalToolsScreen extends StatelessWidget {
  const ProfessionalToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser;
    final affiliationText = user != null && user.college.isNotEmpty
        ? user.college
        : 'No verified affiliation added yet';

    return Scaffold(
      appBar: AppBar(title: const Text('Professional Tools')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.badge_outlined, color: AppTheme.primary),
              title: const Text('Verified Credentials & Affiliations'),
              subtitle: Text(affiliationText),
              trailing: const Icon(Icons.verified_rounded, color: AppTheme.primary),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.handshake_outlined, color: AppTheme.primary),
              title: const Text('Collaboration Inquiries'),
              subtitle: const Text('No open collaboration requests'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.stars_outlined, color: AppTheme.purple),
              title: const Text('Skill Endorsements & Graph'),
              subtitle: const Text('Peer-verified endorsements across verified domains'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

/// Analytics Screen (under More -> Tools)
class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics & Reach')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('30-Day Activity Overview', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _MetricItem(label: 'Profile Visits', value: '0'),
                      _MetricItem(label: 'Post Views', value: '0'),
                      _MetricItem(label: 'Engagements', value: '0'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Audience Distribution by Circle', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  Text(
                    'No circle distribution metrics yet. Insights will appear once members engage with your publications.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  const _MetricItem({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.primary)),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

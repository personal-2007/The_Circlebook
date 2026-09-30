import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'subscreens/activity_subscreens.dart';
import 'subscreens/explore_subscreens.dart';
import 'subscreens/intelligence_subscreens.dart';
import 'subscreens/tools_subscreens.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  void _showReportProblemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Report a Problem'),
        content: const TextField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Describe the bug, broken layout, or issue...',
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Thank you. Problem report submitted to engineers.')),
              );
            },
            child: const Text('Submit Report'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Features'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          // 1. Explore Section
          _SectionHeader(title: 'Explore', icon: Icons.explore_outlined, color: AppTheme.primary),
          _MoreMenuCard(
            children: [
              _MoreMenuItem(
                title: 'Groups',
                subtitle: 'Active communities and subject guilds',
                icon: Icons.groups_rounded,
                iconColor: AppTheme.primary,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const GroupsScreen()),
                ),
              ),
              const Divider(height: 1),
              _MoreMenuItem(
                title: 'Events',
                subtitle: 'Upcoming colloquia, seminars, and meetups',
                icon: Icons.event_available_rounded,
                iconColor: AppTheme.secondary,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const EventsScreen()),
                ),
              ),
              const Divider(height: 1),
              _MoreMenuItem(
                title: 'Watch',
                subtitle: 'Recorded lectures, teardowns, and podcasts',
                icon: Icons.play_circle_outline_rounded,
                iconColor: AppTheme.purple,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const WatchScreen()),
                ),
              ),
              const Divider(height: 1),
              _MoreMenuItem(
                title: 'Marketplace',
                subtitle: 'Peer-to-peer books, hardware, and equipment',
                icon: Icons.storefront_outlined,
                iconColor: AppTheme.accent,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MarketplaceScreen()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 2. Your Activity Section
          _SectionHeader(title: 'Your Activity', icon: Icons.bookmark_border_rounded, color: AppTheme.purple),
          _MoreMenuCard(
            children: [
              _MoreMenuItem(
                title: 'Saved',
                subtitle: 'Articles, posts, and media saved for later',
                icon: Icons.bookmark_outline_rounded,
                iconColor: AppTheme.primary,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SavedScreen()),
                ),
              ),
              const Divider(height: 1),
              _MoreMenuItem(
                title: 'Memories',
                subtitle: 'On this day in previous years',
                icon: Icons.history_edu_rounded,
                iconColor: AppTheme.secondary,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MemoriesScreen()),
                ),
              ),
              const Divider(height: 1),
              _MoreMenuItem(
                title: 'Archive',
                subtitle: 'Archived posts and past conversations',
                icon: Icons.archive_outlined,
                iconColor: AppTheme.purple,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ArchiveScreen()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 3. Tools Section
          _SectionHeader(title: 'Tools', icon: Icons.build_outlined, color: AppTheme.secondary),
          _MoreMenuCard(
            children: [
              _MoreMenuItem(
                title: 'Creator Tools',
                subtitle: 'Audience growth, drafts, and publication suite',
                icon: Icons.design_services_outlined,
                iconColor: AppTheme.primary,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CreatorToolsScreen()),
                ),
              ),
              const Divider(height: 1),
              _MoreMenuItem(
                title: 'Professional Tools',
                subtitle: 'Verified credentials, collaboration requests',
                icon: Icons.badge_outlined,
                iconColor: AppTheme.purple,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ProfessionalToolsScreen()),
                ),
              ),
              const Divider(height: 1),
              _MoreMenuItem(
                title: 'Analytics',
                subtitle: 'Reach, engagement rate, and profile views',
                icon: Icons.insights_rounded,
                iconColor: AppTheme.accent,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AnalyticsScreen()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 4. Intelligence Section
          _SectionHeader(title: 'Intelligence', icon: Icons.auto_awesome_rounded, color: AppTheme.purple),
          _MoreMenuCard(
            children: [
              _MoreMenuItem(
                title: 'Circle AI',
                subtitle: 'Synthesize discussions, analyze papers, draft posts',
                icon: Icons.auto_awesome_rounded,
                iconColor: AppTheme.purple,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CircleAIScreen()),
                ),
              ),
              const Divider(height: 1),
              _MoreMenuItem(
                title: 'Smart Search',
                subtitle: 'Semantic query engine and discovery',
                icon: Icons.manage_search_rounded,
                iconColor: AppTheme.primary,
                onTap: () => Navigator.of(context).pushNamed('/app/search'),
              ),
              const Divider(height: 1),
              _MoreMenuItem(
                title: 'Recommendations Control',
                subtitle: 'Adjust recommendation weights and transparency',
                icon: Icons.tune_rounded,
                iconColor: AppTheme.secondary,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const RecommendationsControlScreen()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 5. Support Section
          _SectionHeader(title: 'Support', icon: Icons.help_outline_rounded, color: AppTheme.textMuted),
          _MoreMenuCard(
            children: [
              _MoreMenuItem(
                title: 'Help & Support',
                subtitle: 'Documentation, guides, and FAQs',
                icon: Icons.help_outline_rounded,
                iconColor: AppTheme.primary,
                onTap: () => Navigator.of(context).pushNamed('/app/settings/support'),
              ),
              const Divider(height: 1),
              _MoreMenuItem(
                title: 'Report a Problem',
                subtitle: 'Submit bug reports or layout issues',
                icon: Icons.bug_report_outlined,
                iconColor: AppTheme.warning,
                onTap: () => _showReportProblemDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 6. Account Section
          _SectionHeader(title: 'Account', icon: Icons.settings_outlined, color: AppTheme.deepNavy),
          _MoreMenuCard(
            children: [
              _MoreMenuItem(
                title: 'Settings',
                subtitle: 'Account, privacy, security, and appearance',
                icon: Icons.settings_outlined,
                iconColor: AppTheme.primary,
                onTap: () => Navigator.of(context).pushNamed('/app/settings'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.icon,
    required this.color,
  });

  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _MoreMenuCard extends StatelessWidget {
  const _MoreMenuCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: children,
      ),
    );
  }
}

class _MoreMenuItem extends StatelessWidget {
  const _MoreMenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: iconColor.withAlpha(25),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, size: 18),
    );
  }
}

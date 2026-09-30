import 'package:flutter/material.dart';

import '../../../data/mock_data.dart';
import '../../../models/circlebook_models.dart';
import '../../../theme/app_theme.dart';

/// Groups Screen (under More -> Explore)
class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final List<CircleCommunity> _groups = List.from(MockData.communities);

  void _handleGroupMenuAction(String action, CircleCommunity group) {
    switch (action) {
      case 'notifications':
        final index = _groups.indexWhere((c) => c.id == group.id);
        if (index != -1) {
          setState(() {
            _groups[index] = _groups[index].copyWith(
              notificationsEnabled: !_groups[index].notificationsEnabled,
            );
          });
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(group.notificationsEnabled ? 'Notifications muted' : 'Notifications enabled')),
        );
        break;
      case 'share':
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Share Group'),
            content: Text('Share invite link for "${group.name}":\nhttps://circlebook.org/groups/${group.id}'),
            actions: [
              FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('Copy Link')),
            ],
          ),
        );
        break;
      case 'leave':
        final index = _groups.indexWhere((c) => c.id == group.id);
        if (index != -1) {
          setState(() {
            _groups[index] = _groups[index].copyWith(isJoined: false);
          });
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Left ${group.name}')),
        );
        break;
      case 'report':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Group reported to Trust & Safety.')),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Groups & Communities')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _groups.length,
        itemBuilder: (context, index) {
          final g = _groups[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(Icons.groups_rounded, color: AppTheme.primary, size: 28),
              title: Text(g.name, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text('${g.memberCount} members • ${g.category}'),
              trailing: PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert_rounded),
                onSelected: (val) => _handleGroupMenuAction(val, g),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'notifications',
                    child: Text(g.notificationsEnabled ? 'Mute Notifications' : 'Enable Notifications'),
                  ),
                  const PopupMenuItem(value: 'share', child: Text('Share')),
                  if (g.isJoined)
                    const PopupMenuItem(value: 'leave', child: Text('Leave Group')),
                  const PopupMenuItem(value: 'report', child: Text('Report', style: TextStyle(color: AppTheme.danger))),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Events Screen (under More -> Explore)
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events & Colloquia')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.events.length,
        itemBuilder: (context, index) {
          final e = MockData.events[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 6),
                  Text('${e.date} • ${e.location}', style: const TextStyle(color: AppTheme.primary, fontSize: 13)),
                  const SizedBox(height: 6),
                  Text(e.description),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Watch Screen (under More -> Explore)
class WatchScreen extends StatelessWidget {
  const WatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watch & Lectures')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.watchItems.length,
        itemBuilder: (context, index) {
          final w = MockData.watchItems[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer.withAlpha(120),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.play_arrow_rounded, color: AppTheme.primary, size: 32),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(w.category, style: const TextStyle(fontSize: 11.5, color: AppTheme.primary, fontWeight: FontWeight.w700)),
                          Text(w.duration, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(w.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text('${w.creatorName} • ${w.views} views • ${w.timeAgo}', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Marketplace Screen (under More -> Explore)
class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Circle Marketplace')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.marketItems.length,
        itemBuilder: (context, index) {
          final m = MockData.marketItems[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.storefront_outlined, color: AppTheme.primary),
              ),
              title: Text(m.title, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text('${m.condition} • ${m.seller} (${m.location})'),
              trailing: Text(
                m.price,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppTheme.primary),
              ),
            ),
          );
        },
      ),
    );
  }
}

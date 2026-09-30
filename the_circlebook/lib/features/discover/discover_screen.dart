import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/circlebook_models.dart';
import '../../theme/app_theme.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final List<CircleCommunity> _communities = List.from(MockData.communities);
  final List<CircleEvent> _events = List.from(MockData.events);

  void _handleGroupMenuAction(String action, CircleCommunity group) {
    switch (action) {
      case 'notifications':
        final index = _communities.indexWhere((c) => c.id == group.id);
        if (index != -1) {
          setState(() {
            _communities[index] = _communities[index].copyWith(
              notificationsEnabled: !_communities[index].notificationsEnabled,
            );
          });
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(group.notificationsEnabled
                ? 'Notifications muted for ${group.name}'
                : 'Notifications enabled for ${group.name}'),
          ),
        );
        break;
      case 'share':
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Share Group'),
            content: Text('Share invite link for "${group.name}":\nhttps://circlebook.org/groups/${group.id}'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
              FilledButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Group invite link copied.')),
                  );
                },
                child: const Text('Copy Link'),
              ),
            ],
          ),
        );
        break;
      case 'leave':
        final index = _communities.indexWhere((c) => c.id == group.id);
        if (index != -1) {
          setState(() {
            _communities[index] = _communities[index].copyWith(isJoined: false);
          });
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You have left ${group.name}.')),
        );
        break;
      case 'report':
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Report Group'),
            content: Text('Report ${group.name} for policy violations?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
              FilledButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Report submitted to Trust & Safety.')),
                  );
                },
                child: const Text('Submit Report'),
              ),
            ],
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        // Smart Search Trigger Banner
        Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => Navigator.of(context).pushNamed('/app/search'),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Icon(Icons.search_rounded, color: theme.colorScheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Smart Search & Discovery',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Explore people, papers, events, and communities',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // People Recommendations
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recommended Connections',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed('/app/people'),
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: MockData.suggestedPeople.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final person = MockData.suggestedPeople[index];
              return Container(
                width: 160,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Text(
                        person.name.split(' ').map((p) => p[0]).take(2).join(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      person.name,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      person.headline,
                      style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    FilledButton.tonal(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Connection sent to ${person.name}')),
                        );
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 30),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text('Connect', style: TextStyle(fontSize: 11.5)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),

        // Community Recommendations (with contextual 3-dot group menu)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recommended Communities',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed('/app/more/groups'),
              child: const Text('Explore Groups'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ..._communities.map((comm) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          comm.name[0],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comm.name,
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5),
                            ),
                            Text(
                              '${comm.memberCount} members • ${comm.category}',
                              style: theme.textTheme.labelMedium?.copyWith(fontSize: 11.5),
                            ),
                          ],
                        ),
                      ),
                      // Contextual Three-Dot Menu: Group (Notifications, Share, Leave, Report)
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert_rounded, size: 18),
                        tooltip: 'Group options',
                        onSelected: (val) => _handleGroupMenuAction(val, comm),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'notifications',
                            child: Row(
                              children: [
                                Icon(comm.notificationsEnabled ? Icons.notifications_off_outlined : Icons.notifications_active_outlined, size: 18),
                                const SizedBox(width: 10),
                                Text(comm.notificationsEnabled ? 'Mute Notifications' : 'Enable Notifications'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'share',
                            child: Row(
                              children: [
                                Icon(Icons.share_outlined, size: 18),
                                SizedBox(width: 10),
                                Text('Share Group'),
                              ],
                            ),
                          ),
                          if (comm.isJoined)
                            const PopupMenuItem(
                              value: 'leave',
                              child: Row(
                                children: [
                                  Icon(Icons.exit_to_app_rounded, size: 18),
                                  SizedBox(width: 10),
                                  Text('Leave Group'),
                                ],
                              ),
                            ),
                          const PopupMenuItem(
                            value: 'report',
                            child: Row(
                              children: [
                                Icon(Icons.flag_outlined, size: 18, color: AppTheme.danger),
                                SizedBox(width: 10),
                                Text('Report Group', style: TextStyle(color: AppTheme.danger)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(comm.description, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13)),
                  const SizedBox(height: 12),
                  FilledButton.tonal(
                    onPressed: () {
                      final index = _communities.indexWhere((c) => c.id == comm.id);
                      if (index != -1) {
                        setState(() {
                          _communities[index] = _communities[index].copyWith(isJoined: !_communities[index].isJoined);
                        });
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(comm.isJoined ? 'Left ${comm.name}' : 'Joined ${comm.name}!')),
                      );
                    },
                    style: FilledButton.styleFrom(minimumSize: const Size(90, 34)),
                    child: Text(comm.isJoined ? 'Joined' : 'Join'),
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 20),

        // Event Recommendations
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Events',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed('/app/more/events'),
              child: const Text('All Events'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ..._events.map((event) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 14, color: theme.colorScheme.primary),
                      const SizedBox(width: 6),
                      Text(event.date, style: const TextStyle(fontSize: 12.5)),
                      const SizedBox(width: 14),
                      Icon(Icons.location_on_outlined, size: 14, color: theme.textTheme.bodySmall?.color),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.location,
                          style: theme.textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(event.description, style: theme.textTheme.bodySmall),
                  const SizedBox(height: 12),
                  FilledButton.tonal(
                    onPressed: () {
                      final index = _events.indexWhere((e) => e.id == event.id);
                      if (index != -1) {
                        setState(() {
                          _events[index] = _events[index].copyWith(isAttending: !_events[index].isAttending);
                        });
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(event.isAttending ? 'RSVP cancelled' : 'RSVP confirmed!')),
                      );
                    },
                    style: FilledButton.styleFrom(minimumSize: const Size(90, 34)),
                    child: Text(event.isAttending ? 'Attending' : 'RSVP'),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

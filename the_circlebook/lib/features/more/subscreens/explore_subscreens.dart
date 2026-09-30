import 'package:flutter/material.dart';

import '../../../models/circlebook_models.dart';
import '../../../repositories/community_repository.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/empty_state_view.dart';
import '../../../widgets/error_state_view.dart';
import '../../../widgets/loading_state_view.dart';

/// Groups Screen (under More -> Explore)
class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final CommunityRepository _repository = CommunityRepository();
  List<CircleCommunity> _groups = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final list = await _repository.getGroups();
      if (mounted) {
        setState(() {
          _groups = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

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
      body: RefreshIndicator(
        onRefresh: _loadGroups,
        child: _isLoading
            ? const LoadingStateView(message: 'Loading communities...')
            : _errorMessage != null
                ? ErrorStateView(onRetry: _loadGroups)
                : _groups.isEmpty
                    ? const EmptyStateView(
                        title: 'No groups yet.',
                        message: 'Subject communities and academic guilds will appear here.',
                        icon: Icons.groups_rounded,
                      )
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: _groups.length,
                        itemBuilder: (context, index) {
                          final g = _groups[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: const Icon(Icons.groups_rounded, color: AppTheme.primary, size: 28),
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
      ),
    );
  }
}

/// Events Screen (under More -> Explore)
class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final CommunityRepository _repository = CommunityRepository();
  List<CircleEvent> _events = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final list = await _repository.getEvents();
      if (mounted) {
        setState(() {
          _events = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events & Colloquia')),
      body: RefreshIndicator(
        onRefresh: _loadEvents,
        child: _isLoading
            ? const LoadingStateView(message: 'Loading events...')
            : _errorMessage != null
                ? ErrorStateView(onRetry: _loadEvents)
                : _events.isEmpty
                    ? const EmptyStateView(
                        title: 'No events yet.',
                        message: 'Upcoming colloquia, seminars, and meetups will appear here.',
                        icon: Icons.event_available_rounded,
                      )
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: _events.length,
                        itemBuilder: (context, index) {
                          final e = _events[index];
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
                                  if (e.description.isNotEmpty) ...[
                                    const SizedBox(height: 6),
                                    Text(e.description),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
      ),
    );
  }
}

/// Watch Screen (under More -> Explore)
class WatchScreen extends StatefulWidget {
  const WatchScreen({super.key});

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  final CommunityRepository _repository = CommunityRepository();
  List<CircleWatchItem> _watchItems = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadWatchItems();
  }

  Future<void> _loadWatchItems() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final list = await _repository.getWatchItems();
      if (mounted) {
        setState(() {
          _watchItems = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watch & Lectures')),
      body: RefreshIndicator(
        onRefresh: _loadWatchItems,
        child: _isLoading
            ? const LoadingStateView(message: 'Loading lectures...')
            : _errorMessage != null
                ? ErrorStateView(onRetry: _loadWatchItems)
                : _watchItems.isEmpty
                    ? const EmptyStateView(
                        title: 'No videos yet.',
                        message: 'Recorded lectures, presentations, and tutorials will appear here.',
                        icon: Icons.play_circle_outline_rounded,
                      )
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: _watchItems.length,
                        itemBuilder: (context, index) {
                          final w = _watchItems[index];
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
      ),
    );
  }
}

/// Marketplace Screen (under More -> Explore)
class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final CommunityRepository _repository = CommunityRepository();
  List<CircleMarketItem> _marketItems = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMarketItems();
  }

  Future<void> _loadMarketItems() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final list = await _repository.getMarketItems();
      if (mounted) {
        setState(() {
          _marketItems = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Circle Marketplace')),
      body: RefreshIndicator(
        onRefresh: _loadMarketItems,
        child: _isLoading
            ? const LoadingStateView(message: 'Loading marketplace...')
            : _errorMessage != null
                ? ErrorStateView(onRetry: _loadMarketItems)
                : _marketItems.isEmpty
                    ? const EmptyStateView(
                        title: 'No marketplace items yet.',
                        message: 'Peer-to-peer books, research hardware, and supplies will appear here.',
                        icon: Icons.storefront_outlined,
                      )
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: _marketItems.length,
                        itemBuilder: (context, index) {
                          final m = _marketItems[index];
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
      ),
    );
  }
}

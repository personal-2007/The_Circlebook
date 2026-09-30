import 'package:flutter/material.dart';

import '../../models/circlebook_models.dart';
import '../../repositories/notification_repository.dart';
import '../../theme/app_theme.dart';
import '../../widgets/empty_state_view.dart';
import '../../widgets/error_state_view.dart';
import '../../widgets/loading_state_view.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final NotificationRepository _notificationRepository = NotificationRepository();
  List<CircleNotification> _notifications = [];
  bool _isLoading = true;
  String? _errorMessage;
  int _activeFilter = 0; // 0: All, 1: Unread, 2: Connections, 3: Security

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final list = await _notificationRepository.getNotifications();
      if (mounted) {
        setState(() {
          _notifications = list;
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

  Future<void> _markAllAsRead() async {
    setState(() {
      for (int i = 0; i < _notifications.length; i++) {
        _notifications[i] = _notifications[i].copyWith(isUnread: false);
      }
    });
    try {
      await _notificationRepository.markAllAsRead();
    } catch (_) {}
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All notifications marked as read.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _notifications.where((n) {
      if (_activeFilter == 1) return n.isUnread;
      if (_activeFilter == 2) return n.category == 'connection';
      if (_activeFilter == 3) return n.category == 'security';
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all_rounded),
            tooltip: 'Mark all as read',
            onPressed: _notifications.isEmpty ? null : _markAllAsRead,
          ),
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            tooltip: 'Notification preferences',
            onPressed: () => Navigator.of(context).pushNamed('/app/settings/notifications'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadNotifications,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // Filter Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _NotifFilterChip(
                    label: 'All',
                    isSelected: _activeFilter == 0,
                    onSelected: () => setState(() => _activeFilter = 0),
                  ),
                  const SizedBox(width: 8),
                  _NotifFilterChip(
                    label: 'Unread',
                    isSelected: _activeFilter == 1,
                    onSelected: () => setState(() => _activeFilter = 1),
                  ),
                  const SizedBox(width: 8),
                  _NotifFilterChip(
                    label: 'Connections',
                    isSelected: _activeFilter == 2,
                    onSelected: () => setState(() => _activeFilter = 2),
                  ),
                  const SizedBox(width: 8),
                  _NotifFilterChip(
                    label: 'Security & Alerts',
                    isSelected: _activeFilter == 3,
                    onSelected: () => setState(() => _activeFilter = 3),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            if (_isLoading)
              const LoadingStateView(message: 'Loading notifications...')
            else if (_errorMessage != null)
              ErrorStateView(onRetry: _loadNotifications)
            else if (filtered.isEmpty)
              const EmptyStateView(
                title: 'No notifications yet.',
                message: 'System alerts, circle invitations, and activity updates will appear here.',
                icon: Icons.notifications_none_rounded,
              )
            else ...[
              ...filtered.map((n) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  color: n.isUnread ? Theme.of(context).colorScheme.primaryContainer.withAlpha(25) : null,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _getCategoryColor(n.category).withAlpha(30),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        _getCategoryIcon(n.category),
                        color: _getCategoryColor(n.category),
                        size: 20,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            n.title,
                            style: TextStyle(
                              fontWeight: n.isUnread ? FontWeight.w800 : FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(n.time, style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 11)),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        n.detail,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'connection':
        return Icons.person_add_alt_1_rounded;
      case 'community':
        return Icons.groups_rounded;
      case 'event':
        return Icons.event_rounded;
      case 'security':
        return Icons.shield_outlined;
      default:
        return Icons.notifications_none_rounded;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'connection':
        return AppTheme.primary;
      case 'community':
        return AppTheme.purple;
      case 'event':
        return AppTheme.secondary;
      case 'security':
        return AppTheme.danger;
      default:
        return AppTheme.textMuted;
    }
  }
}

class _NotifFilterChip extends StatelessWidget {
  const _NotifFilterChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onSelected,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surfaceContainerHighest.withAlpha(120),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? theme.colorScheme.primary : theme.textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }
}

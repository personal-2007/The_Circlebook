import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/circlebook_models.dart';
import '../../theme/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<CircleNotification> _notifications = List.from(MockData.notifications);
  int _activeFilter = 0; // 0: All, 1: Unread, 2: Connections, 3: Security

  void _markAllAsRead() {
    setState(() {
      for (int i = 0; i < _notifications.length; i++) {
        _notifications[i] = _notifications[i].copyWith(isUnread: false);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All notifications marked as read.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            onPressed: _markAllAsRead,
          ),
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            tooltip: 'Notification preferences',
            onPressed: () => Navigator.of(context).pushNamed('/app/settings/notifications'),
          ),
        ],
      ),
      body: ListView(
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

          if (filtered.isEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text(
                  'No notifications in this filter',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
              ),
            ),
          ] else ...[
            ...filtered.map((item) {
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                color: item.isUnread
                    ? theme.colorScheme.primaryContainer.withAlpha(50)
                    : theme.cardColor,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  leading: CircleAvatar(
                    backgroundColor: item.category == 'security'
                        ? AppTheme.warning.withAlpha(40)
                        : theme.colorScheme.primaryContainer,
                    child: Icon(
                      item.category == 'security'
                          ? Icons.shield_outlined
                          : item.category == 'connection'
                              ? Icons.person_add_outlined
                              : Icons.notifications_none_rounded,
                      color: item.category == 'security'
                          ? AppTheme.warning
                          : theme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontWeight: item.isUnread ? FontWeight.w700 : FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      if (item.isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppTheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.detail, style: const TextStyle(fontSize: 12.5)),
                        const SizedBox(height: 4),
                        Text(
                          item.time,
                          style: theme.textTheme.labelMedium?.copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    final index = _notifications.indexWhere((n) => n.id == item.id);
                    if (index != -1) {
                      setState(() {
                        _notifications[index] = _notifications[index].copyWith(isUnread: false);
                      });
                    }
                  },
                ),
              );
            }),
          ],
        ],
      ),
    );
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
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      selectedColor: theme.colorScheme.primaryContainer,
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        color: isSelected ? theme.colorScheme.primary : theme.textTheme.bodyMedium?.color,
      ),
    );
  }
}

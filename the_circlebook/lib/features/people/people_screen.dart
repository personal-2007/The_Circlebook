import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/circlebook_models.dart';
import '../../theme/app_theme.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  int _selectedFilter = 0; // 0: Suggested, 1: Your Circles, 2: Requests
  final List<CircleUser> _people = List.from(MockData.suggestedPeople);
  String _searchQuery = '';

  void _handleProfileMenu(String action, CircleUser person) {
    switch (action) {
      case 'share':
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Share Profile'),
            content: Text('Share ${person.name}\'s profile link:\nhttps://circlebook.org/${person.handle.replaceAll('@', '')}'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
              FilledButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile link copied to clipboard.')),
                  );
                },
                child: const Text('Copy Link'),
              ),
            ],
          ),
        );
        break;
      case 'block':
        setState(() {
          _people.removeWhere((p) => p.id == person.id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${person.name} has been blocked.')),
        );
        break;
      case 'restrict':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${person.name} is now restricted.')),
        );
        break;
      case 'report':
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Report Account'),
            content: Text('Report ${person.name} for violating community guidelines.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
              FilledButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Report submitted to Trust & Safety.')),
                  );
                },
                child: const Text('Submit'),
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

    final filteredList = _people.where((p) {
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matches = p.name.toLowerCase().contains(q) ||
            p.handle.toLowerCase().contains(q) ||
            p.headline.toLowerCase().contains(q);
        if (!matches) return false;
      }
      if (_selectedFilter == 1) return p.isConnected;
      if (_selectedFilter == 2) return !p.isConnected && p.id == 'usr_005';
      return true;
    }).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        // Search bar
        TextField(
          onChanged: (val) => setState(() => _searchQuery = val),
          decoration: InputDecoration(
            hintText: 'Search people by name, skill, or role...',
            prefixIcon: const Icon(Icons.search_rounded, size: 20),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear_rounded, size: 18),
                    onPressed: () => setState(() => _searchQuery = ''),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 14),

        // Tabs
        Row(
          children: [
            _FilterTab(
              label: 'Suggested',
              isSelected: _selectedFilter == 0,
              onTap: () => setState(() => _selectedFilter = 0),
            ),
            const SizedBox(width: 8),
            _FilterTab(
              label: 'Your Circles (42)',
              isSelected: _selectedFilter == 1,
              onTap: () => setState(() => _selectedFilter = 1),
            ),
            const SizedBox(width: 8),
            _FilterTab(
              label: 'Requests (1)',
              isSelected: _selectedFilter == 2,
              onTap: () => setState(() => _selectedFilter = 2),
            ),
          ],
        ),
        const SizedBox(height: 16),

        if (filteredList.isEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Text(
                'No connections found matching "$_searchQuery"',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
            ),
          ),
        ] else ...[
          ...filteredList.map((person) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Text(
                        person.name.split(' ').map((p) => p[0]).take(2).join(),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  person.name,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              // Contextual 3-dot menu for Profile (Share, Block, Restrict, Report)
                              Semantics(
                                label: 'Options for ${person.name}',
                                button: true,
                                child: PopupMenuButton<String>(
                                  icon: const Icon(Icons.more_vert_rounded, size: 18),
                                  tooltip: 'Profile actions',
                                  onSelected: (val) => _handleProfileMenu(val, person),
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'share',
                                      child: Row(
                                        children: [
                                          Icon(Icons.share_outlined, size: 18),
                                          SizedBox(width: 10),
                                          Text('Share Profile'),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'restrict',
                                      child: Row(
                                        children: [
                                          Icon(Icons.shield_outlined, size: 18),
                                          SizedBox(width: 10),
                                          Text('Restrict'),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'block',
                                      child: Row(
                                        children: [
                                          Icon(Icons.block_rounded, size: 18, color: AppTheme.danger),
                                          SizedBox(width: 10),
                                          Text('Block', style: TextStyle(color: AppTheme.danger)),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: 'report',
                                      child: Row(
                                        children: [
                                          Icon(Icons.flag_outlined, size: 18, color: AppTheme.danger),
                                          SizedBox(width: 10),
                                          Text('Report', style: TextStyle(color: AppTheme.danger)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            person.handle,
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            person.headline,
                            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            children: person.skills.take(2).map((s) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(s, style: const TextStyle(fontSize: 11)),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              FilledButton.tonal(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        person.isConnected
                                            ? 'Disconnected from ${person.name}'
                                            : 'Connection invitation sent to ${person.name}',
                                      ),
                                    ),
                                  );
                                },
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size(90, 34),
                                  padding: const EdgeInsets.symmetric(horizontal: 14),
                                ),
                                child: Text(person.isConnected ? 'Connected' : 'Connect'),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/app/messages');
                                },
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(80, 34),
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                ),
                                child: const Text('Message'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ],
    );
  }
}

class _FilterTab extends StatelessWidget {
  const _FilterTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : theme.dividerColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? theme.colorScheme.primary : theme.textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }
}

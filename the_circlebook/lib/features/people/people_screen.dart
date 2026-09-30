import 'package:flutter/material.dart';

import '../../models/circlebook_models.dart';
import '../../repositories/user_repository.dart';
import '../../theme/app_theme.dart';
import '../../widgets/empty_state_view.dart';
import '../../widgets/error_state_view.dart';
import '../../widgets/loading_state_view.dart';

class PeopleScreen extends StatefulWidget {
  const PeopleScreen({super.key});

  @override
  State<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  final UserRepository _userRepository = UserRepository();
  int _selectedFilter = 0; // 0: Suggested, 1: Your Circles, 2: Requests
  List<CircleUser> _people = [];
  bool _isLoading = true;
  String? _errorMessage;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadPeople();
  }

  Future<void> _loadPeople() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final list = await _userRepository.getPeople(
        query: _searchQuery.isNotEmpty ? _searchQuery : null,
        filter: _selectedFilter,
      );
      if (mounted) {
        setState(() {
          _people = list;
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
        _userRepository.blockUser(person.id);
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
      if (_selectedFilter == 2) return !p.isConnected;
      return true;
    }).toList();

    final connectedCount = _people.where((p) => p.isConnected).length;
    final requestsCount = _people.where((p) => !p.isConnected).length;

    return RefreshIndicator(
      onRefresh: _loadPeople,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          // Search bar
          TextField(
            onChanged: (val) {
              setState(() => _searchQuery = val);
              if (val.isEmpty || val.length >= 3) {
                _loadPeople();
              }
            },
            decoration: InputDecoration(
              hintText: 'Search people by name, skill, or role...',
              prefixIcon: const Icon(Icons.search_rounded, size: 20),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 18),
                      onPressed: () {
                        setState(() => _searchQuery = '');
                        _loadPeople();
                      },
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 14),

          // Tabs with dynamic counts
          Row(
            children: [
              _FilterTab(
                label: 'Suggested',
                isSelected: _selectedFilter == 0,
                onTap: () {
                  setState(() => _selectedFilter = 0);
                  _loadPeople();
                },
              ),
              const SizedBox(width: 8),
              _FilterTab(
                label: connectedCount > 0 ? 'Your Circles ($connectedCount)' : 'Your Circles',
                isSelected: _selectedFilter == 1,
                onTap: () {
                  setState(() => _selectedFilter = 1);
                  _loadPeople();
                },
              ),
              const SizedBox(width: 8),
              _FilterTab(
                label: requestsCount > 0 ? 'Requests ($requestsCount)' : 'Requests',
                isSelected: _selectedFilter == 2,
                onTap: () {
                  setState(() => _selectedFilter = 2);
                  _loadPeople();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (_isLoading)
            const LoadingStateView(message: 'Loading people...')
          else if (_errorMessage != null)
            ErrorStateView(onRetry: _loadPeople)
          else if (filteredList.isEmpty) ...[
            if (_selectedFilter == 1)
              const EmptyStateView(
                title: 'No connections yet.',
                message: 'Discover people in your field to build your verified circles.',
                icon: Icons.people_outline_rounded,
              )
            else if (_selectedFilter == 2)
              const EmptyStateView(
                title: 'No connection requests.',
                message: 'When members send you connection requests, they will appear here.',
                icon: Icons.person_add_disabled_outlined,
              )
            else
              EmptyStateView(
                title: 'No people found.',
                message: _searchQuery.isNotEmpty
                    ? 'No members matching "$_searchQuery".'
                    : 'No member recommendations available right now.',
                icon: Icons.person_search_rounded,
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
                          person.name.trim().isNotEmpty
                              ? person.name.trim().split(RegExp(r'\s+')).map((p) => p[0]).take(2).join().toUpperCase()
                              : 'U',
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
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (person.headline.isNotEmpty)
                              Text(
                                person.headline,
                                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13),
                              ),
                            if (person.college.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.school_outlined, size: 14, color: theme.textTheme.bodySmall?.color),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      person.college,
                                      style: theme.textTheme.bodySmall?.copyWith(fontSize: 11.5),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                if (person.isConnected)
                                  OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.check_rounded, size: 16),
                                    label: const Text('Connected'),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                      textStyle: const TextStyle(fontSize: 12),
                                    ),
                                  )
                                else
                                  FilledButton.icon(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Connection request sent to ${person.name}.')),
                                      );
                                    },
                                    icon: const Icon(Icons.person_add_rounded, size: 16),
                                    label: const Text('Connect'),
                                    style: FilledButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                                      textStyle: const TextStyle(fontSize: 12),
                                    ),
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
      ),
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
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surfaceContainerHighest.withAlpha(120),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            width: 1,
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

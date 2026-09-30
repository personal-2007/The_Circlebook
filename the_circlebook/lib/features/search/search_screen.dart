import 'package:flutter/material.dart';

import '../../data/mock_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  int _activeCategory = 0; // 0: All, 1: People, 2: Communities, 3: Events, 4: Posts
  String _query = '';

  final List<String> _recentSearches = [
    'Design Systems',
    'AI & Vector Search',
    'IIT Bombay alumni',
    'Open Source meetups',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final matchingPeople = MockData.suggestedPeople.where((p) {
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      return p.name.toLowerCase().contains(q) ||
          p.headline.toLowerCase().contains(q) ||
          p.skills.any((s) => s.toLowerCase().contains(q));
    }).toList();

    final matchingCommunities = MockData.communities.where((c) {
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      return c.name.toLowerCase().contains(q) ||
          c.description.toLowerCase().contains(q) ||
          c.category.toLowerCase().contains(q);
    }).toList();

    final matchingEvents = MockData.events.where((e) {
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      return e.title.toLowerCase().contains(q) || e.location.toLowerCase().contains(q);
    }).toList();

    final matchingPosts = MockData.posts.where((p) {
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      return p.content.toLowerCase().contains(q) || p.tags.any((t) => t.toLowerCase().contains(q));
    }).toList();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: (val) => setState(() => _query = val),
          decoration: InputDecoration(
            hintText: 'Search people, skills, groups...',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            suffixIcon: _query.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear_rounded, size: 20),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _query = '');
                    },
                  )
                : null,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _CategoryChip(
                  label: 'All Results',
                  isSelected: _activeCategory == 0,
                  onSelected: () => setState(() => _activeCategory = 0),
                ),
                const SizedBox(width: 8),
                _CategoryChip(
                  label: 'People',
                  isSelected: _activeCategory == 1,
                  onSelected: () => setState(() => _activeCategory = 1),
                ),
                const SizedBox(width: 8),
                _CategoryChip(
                  label: 'Communities',
                  isSelected: _activeCategory == 2,
                  onSelected: () => setState(() => _activeCategory = 2),
                ),
                const SizedBox(width: 8),
                _CategoryChip(
                  label: 'Events',
                  isSelected: _activeCategory == 3,
                  onSelected: () => setState(() => _activeCategory = 3),
                ),
                const SizedBox(width: 8),
                _CategoryChip(
                  label: 'Discussions',
                  isSelected: _activeCategory == 4,
                  onSelected: () => setState(() => _activeCategory = 4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          if (_query.isEmpty) ...[
            Text('Recent Searches', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _recentSearches.map((s) {
                return ActionChip(
                  avatar: const Icon(Icons.history_rounded, size: 16),
                  label: Text(s),
                  onPressed: () {
                    _searchController.text = s;
                    setState(() => _query = s);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text('Trending Topics in Your Circles', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ...['#DesignSystems', '#VectorSearch', '#PrivacyFirst', '#OpenSource'].map((topic) {
              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.trending_up_rounded, size: 20),
                title: Text(topic, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: const Text('Highlighted in 14 recent circle posts'),
                onTap: () {
                  _searchController.text = topic;
                  setState(() => _query = topic);
                },
              );
            }),
          ] else ...[
            // People Results
            if ((_activeCategory == 0 || _activeCategory == 1) && matchingPeople.isNotEmpty) ...[
              Text('People (${matchingPeople.length})', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              ...matchingPeople.map((person) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Text(person.name[0], style: TextStyle(fontWeight: FontWeight.w700, color: theme.colorScheme.primary)),
                    ),
                    title: Text(person.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text(person.headline, maxLines: 1, overflow: TextOverflow.ellipsis),
                    trailing: FilledButton.tonal(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Connected to ${person.name}')),
                        );
                      },
                      style: FilledButton.styleFrom(minimumSize: const Size(70, 32)),
                      child: const Text('Connect', style: TextStyle(fontSize: 12)),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
            ],

            // Communities Results
            if ((_activeCategory == 0 || _activeCategory == 2) && matchingCommunities.isNotEmpty) ...[
              Text('Communities (${matchingCommunities.length})', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              ...matchingCommunities.map((c) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Icon(Icons.groups_rounded, color: theme.colorScheme.primary),
                    title: Text(c.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text('${c.memberCount} members • ${c.category}'),
                    trailing: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Joined ${c.name}')),
                        );
                      },
                      style: OutlinedButton.styleFrom(minimumSize: const Size(60, 32)),
                      child: const Text('Join', style: TextStyle(fontSize: 12)),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
            ],

            // Events Results
            if ((_activeCategory == 0 || _activeCategory == 3) && matchingEvents.isNotEmpty) ...[
              Text('Events (${matchingEvents.length})', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              ...matchingEvents.map((e) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Icon(Icons.event_available_rounded, color: theme.colorScheme.secondary),
                    title: Text(e.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text('${e.date} • ${e.location}'),
                  ),
                );
              }),
              const SizedBox(height: 16),
            ],

            // Posts Results
            if ((_activeCategory == 0 || _activeCategory == 4) && matchingPosts.isNotEmpty) ...[
              Text('Discussions (${matchingPosts.length})', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              ...matchingPosts.map((p) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.authorName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                        const SizedBox(height: 4),
                        Text(p.content, maxLines: 2, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ],
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
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
        fontSize: 12.5,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        color: isSelected ? theme.colorScheme.primary : theme.textTheme.bodyMedium?.color,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../models/circlebook_models.dart';
import '../../repositories/community_repository.dart';
import '../../repositories/post_repository.dart';
import '../../repositories/user_repository.dart';
import '../../widgets/empty_state_view.dart';
import '../../widgets/loading_state_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final UserRepository _userRepository = UserRepository();
  final CommunityRepository _communityRepository = CommunityRepository();
  final PostRepository _postRepository = PostRepository();

  int _activeCategory = 0; // 0: All, 1: People, 2: Communities, 3: Events, 4: Posts
  String _query = '';
  bool _isLoading = false;

  List<CircleUser> _matchingPeople = [];
  List<CircleCommunity> _matchingCommunities = [];
  List<CircleEvent> _matchingEvents = [];
  List<CirclePost> _matchingPosts = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String val) async {
    final q = val.trim();
    setState(() {
      _query = q;
    });

    if (q.isEmpty) {
      setState(() {
        _matchingPeople = [];
        _matchingCommunities = [];
        _matchingEvents = [];
        _matchingPosts = [];
        _isLoading = false;
      });
      return;
    }

    setState(() => _isLoading = true);

    try {
      final results = await Future.wait([
        _userRepository.getPeople(query: q),
        _communityRepository.getGroups(),
        _communityRepository.getEvents(),
        _postRepository.getFeed(),
      ]);

      if (mounted) {
        final people = results[0] as List<CircleUser>;
        final groups = (results[1] as List<CircleCommunity>).where((c) {
          final lq = q.toLowerCase();
          return c.name.toLowerCase().contains(lq) ||
              c.description.toLowerCase().contains(lq) ||
              c.category.toLowerCase().contains(lq);
        }).toList();
        final events = (results[2] as List<CircleEvent>).where((e) {
          final lq = q.toLowerCase();
          return e.title.toLowerCase().contains(lq) ||
              e.location.toLowerCase().contains(lq) ||
              e.description.toLowerCase().contains(lq);
        }).toList();
        final posts = (results[3] as List<CirclePost>).where((p) {
          final lq = q.toLowerCase();
          return p.content.toLowerCase().contains(lq) ||
              p.tags.any((t) => t.toLowerCase().contains(lq));
        }).toList();

        setState(() {
          _matchingPeople = people;
          _matchingCommunities = groups;
          _matchingEvents = events;
          _matchingPosts = posts;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasAnyResults = _matchingPeople.isNotEmpty ||
        _matchingCommunities.isNotEmpty ||
        _matchingEvents.isNotEmpty ||
        _matchingPosts.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: _performSearch,
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
                      _performSearch('');
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
                  label: 'Posts',
                  isSelected: _activeCategory == 4,
                  onSelected: () => setState(() => _activeCategory = 4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          if (_isLoading)
            const LoadingStateView(message: 'Searching circles...')
          else if (_query.isEmpty)
            const EmptyStateView(
              title: 'Search The Circlebook',
              message: 'Type a query to search across members, subject guilds, events, and discussions.',
              icon: Icons.search_rounded,
            )
          else if (!hasAnyResults)
            EmptyStateView(
              title: 'No results found.',
              message: 'No matches found for "$_query".',
              icon: Icons.search_off_rounded,
            )
          else ...[
            // 1. People matches
            if ((_activeCategory == 0 || _activeCategory == 1) && _matchingPeople.isNotEmpty) ...[
              _SearchSectionHeader(title: 'People (${_matchingPeople.length})', icon: Icons.person_search_rounded),
              ..._matchingPeople.map((person) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Text(
                        person.name.trim().isNotEmpty
                            ? person.name.trim().split(RegExp(r'\s+')).map((p) => p[0]).take(2).join().toUpperCase()
                            : 'U',
                        style: TextStyle(fontWeight: FontWeight.w700, color: theme.colorScheme.primary, fontSize: 12),
                      ),
                    ),
                    title: Text(person.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text('${person.handle} • ${person.headline}', maxLines: 1, overflow: TextOverflow.ellipsis),
                    trailing: const Icon(Icons.chevron_right_rounded, size: 18),
                    onTap: () => Navigator.of(context).pushNamed('/app/people'),
                  ),
                );
              }),
              const SizedBox(height: 14),
            ],

            // 2. Communities matches
            if ((_activeCategory == 0 || _activeCategory == 2) && _matchingCommunities.isNotEmpty) ...[
              _SearchSectionHeader(title: 'Communities (${_matchingCommunities.length})', icon: Icons.groups_rounded),
              ..._matchingCommunities.map((comm) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        comm.name.isNotEmpty ? comm.name[0] : 'G',
                        style: TextStyle(fontWeight: FontWeight.w700, color: theme.colorScheme.primary),
                      ),
                    ),
                    title: Text(comm.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text('${comm.memberCount} members • ${comm.category}'),
                    trailing: const Icon(Icons.chevron_right_rounded, size: 18),
                    onTap: () => Navigator.of(context).pushNamed('/app/more/groups'),
                  ),
                );
              }),
              const SizedBox(height: 14),
            ],

            // 3. Events matches
            if ((_activeCategory == 0 || _activeCategory == 3) && _matchingEvents.isNotEmpty) ...[
              _SearchSectionHeader(title: 'Events (${_matchingEvents.length})', icon: Icons.event_rounded),
              ..._matchingEvents.map((evt) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.calendar_today_rounded),
                    title: Text(evt.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text('${evt.date} • ${evt.location}'),
                    trailing: const Icon(Icons.chevron_right_rounded, size: 18),
                    onTap: () => Navigator.of(context).pushNamed('/app/more/events'),
                  ),
                );
              }),
              const SizedBox(height: 14),
            ],

            // 4. Posts matches
            if ((_activeCategory == 0 || _activeCategory == 4) && _matchingPosts.isNotEmpty) ...[
              _SearchSectionHeader(title: 'Posts (${_matchingPosts.length})', icon: Icons.article_outlined),
              ..._matchingPosts.map((post) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(post.content, maxLines: 2, overflow: TextOverflow.ellipsis),
                    subtitle: Text('By ${post.authorName} • ${post.timestamp}'),
                    trailing: const Icon(Icons.chevron_right_rounded, size: 18),
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

class _SearchSectionHeader extends StatelessWidget {
  const _SearchSectionHeader({required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 6),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

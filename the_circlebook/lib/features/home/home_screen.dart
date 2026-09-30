import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/circlebook_models.dart';
import '../../services/storage_service.dart';
import 'widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    this.onNavigateToCreate,
    super.key,
  });

  final VoidCallback? onNavigateToCreate;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _currentAlgorithm;
  late List<CirclePost> _feedPosts;

  @override
  void initState() {
    super.initState();
    _currentAlgorithm = StorageService.loadFeedAlgorithm();
    _feedPosts = List.from(MockData.posts);
  }

  void _changeAlgorithm(String algo) {
    setState(() {
      _currentAlgorithm = algo;
      StorageService.saveFeedAlgorithm(algo);
      if (algo == 'following') {
        _feedPosts = List.from(MockData.posts.reversed);
      } else if (algo == 'circles') {
        _feedPosts = MockData.posts.where((p) => p.authorId == 'usr_004' || p.authorId == 'usr_002').toList();
      } else {
        _feedPosts = List.from(MockData.posts);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        // Quick composer trigger
        Card(
          margin: const EdgeInsets.only(bottom: 14),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: widget.onNavigateToCreate ?? () => Navigator.of(context).pushNamed('/app/create'),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Text(
                      'AS',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Share an update, paper, or discussion...',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.edit_note_rounded,
                    color: theme.colorScheme.primary,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ),

        // User-Controlled Algorithm Feed Filter (2030 Feature)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Text(
                'Feed View:',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _AlgorithmChoiceChip(
                        label: 'Relevant (For You)',
                        selected: _currentAlgorithm == 'for_you',
                        onSelected: () => _changeAlgorithm('for_you'),
                      ),
                      const SizedBox(width: 6),
                      _AlgorithmChoiceChip(
                        label: 'Chronological',
                        selected: _currentAlgorithm == 'following',
                        onSelected: () => _changeAlgorithm('following'),
                      ),
                      const SizedBox(width: 6),
                      _AlgorithmChoiceChip(
                        label: 'Close Circles',
                        selected: _currentAlgorithm == 'circles',
                        onSelected: () => _changeAlgorithm('circles'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Post cards with contextual menus
        ..._feedPosts.map(
          (post) => PostCard(
            key: ValueKey(post.id),
            post: post,
            onDelete: () {
              setState(() {
                _feedPosts.removeWhere((p) => p.id == post.id);
              });
            },
            onHide: () {
              setState(() {
                _feedPosts.removeWhere((p) => p.id == post.id);
              });
            },
          ),
        ),
      ],
    );
  }
}

class _AlgorithmChoiceChip extends StatelessWidget {
  const _AlgorithmChoiceChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      selected: selected,
      button: true,
      label: 'Sort feed by $label',
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onSelected,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
          decoration: BoxDecoration(
            color: selected
                ? theme.colorScheme.primaryContainer
                : theme.colorScheme.surfaceContainerHighest.withAlpha(120),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected ? theme.colorScheme.primary : Colors.transparent,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected
                  ? theme.colorScheme.primary
                  : theme.textTheme.bodyMedium?.color,
            ),
          ),
        ),
      ),
    );
  }
}

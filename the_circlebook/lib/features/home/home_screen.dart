import 'package:flutter/material.dart';

import '../../models/circlebook_models.dart';
import '../../repositories/post_repository.dart';
import '../../services/auth_service.dart';
import '../../services/storage_service.dart';
import '../../widgets/empty_state_view.dart';
import '../../widgets/error_state_view.dart';
import '../../widgets/loading_state_view.dart';
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
  final PostRepository _postRepository = PostRepository();
  late String _currentAlgorithm;
  List<CirclePost> _feedPosts = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _currentAlgorithm = StorageService.loadFeedAlgorithm();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final posts = await _postRepository.getFeed(algorithm: _currentAlgorithm);
      if (mounted) {
        setState(() {
          _feedPosts = posts;
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

  void _changeAlgorithm(String algo) {
    if (_currentAlgorithm == algo && !_isLoading) return;
    setState(() {
      _currentAlgorithm = algo;
      StorageService.saveFeedAlgorithm(algo);
    });
    _loadPosts();
  }

  String _getUserInitials() {
    final user = AuthService.currentUser;
    if (user == null || user.name.isEmpty) return 'U';
    final parts = user.name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: _loadPosts,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          // Quick composer trigger
          Card(
            margin: const EdgeInsets.only(bottom: 14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: widget.onNavigateToCreate ??
                  () async {
                    await Navigator.of(context).pushNamed('/app/create');
                    _loadPosts();
                  },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Text(
                        _getUserInitials(),
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

          // Content body based on state
          if (_isLoading)
            const LoadingStateView(message: 'Loading feed...')
          else if (_errorMessage != null)
            ErrorStateView(
              onRetry: _loadPosts,
            )
          else if (_feedPosts.isEmpty)
            EmptyStateView(
              title: 'No posts yet.',
              message: 'When members in your circles share posts, they will appear here.',
              actionLabel: 'Create Post',
              onAction: widget.onNavigateToCreate ??
                  () async {
                    await Navigator.of(context).pushNamed('/app/create');
                    _loadPosts();
                  },
            )
          else
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
      ),
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

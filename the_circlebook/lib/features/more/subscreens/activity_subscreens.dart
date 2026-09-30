import 'package:flutter/material.dart';

import '../../../models/circlebook_models.dart';
import '../../../repositories/community_repository.dart';
import '../../../repositories/post_repository.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/empty_state_view.dart';
import '../../../widgets/error_state_view.dart';
import '../../../widgets/loading_state_view.dart';
import '../../home/widgets/post_card.dart';

/// Saved Screen (under More -> Your Activity)
class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final PostRepository _postRepository = PostRepository();
  List<CirclePost> _savedPosts = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final list = await _postRepository.getSavedPosts();
      if (mounted) {
        setState(() {
          _savedPosts = list;
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
      appBar: AppBar(title: const Text('Saved Posts & Links')),
      body: RefreshIndicator(
        onRefresh: _loadSaved,
        child: _isLoading
            ? const LoadingStateView(message: 'Loading saved items...')
            : _errorMessage != null
                ? ErrorStateView(onRetry: _loadSaved)
                : _savedPosts.isEmpty
                    ? const EmptyStateView(
                        title: 'No saved items yet.',
                        message: 'Articles, posts, and media saved for later will appear here.',
                        icon: Icons.bookmark_outline_rounded,
                      )
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: _savedPosts.length,
                        itemBuilder: (context, index) {
                          return PostCard(post: _savedPosts[index]);
                        },
                      ),
      ),
    );
  }
}

/// Memories Screen (under More -> Your Activity)
class MemoriesScreen extends StatefulWidget {
  const MemoriesScreen({super.key});

  @override
  State<MemoriesScreen> createState() => _MemoriesScreenState();
}

class _MemoriesScreenState extends State<MemoriesScreen> {
  final CommunityRepository _communityRepository = CommunityRepository();
  List<CircleMemory> _memories = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMemories();
  }

  Future<void> _loadMemories() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final list = await _communityRepository.getMemories();
      if (mounted) {
        setState(() {
          _memories = list;
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
      appBar: AppBar(title: const Text('Memories')),
      body: RefreshIndicator(
        onRefresh: _loadMemories,
        child: _isLoading
            ? const LoadingStateView(message: 'Loading memories...')
            : _errorMessage != null
                ? ErrorStateView(onRetry: _loadMemories)
                : _memories.isEmpty
                    ? const EmptyStateView(
                        title: 'No memories yet.',
                        message: 'Milestones and previous year posts will appear here over time.',
                        icon: Icons.history_edu_rounded,
                      )
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: _memories.length,
                        itemBuilder: (context, index) {
                          final mem = _memories[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 14),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.history_edu_rounded, color: AppTheme.primary, size: 20),
                                      const SizedBox(width: 8),
                                      Text(mem.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                                      const Spacer(),
                                      Text(mem.dateAgo, style: Theme.of(context).textTheme.bodySmall),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(mem.snippet, style: const TextStyle(fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 12),
                                  const Divider(),
                                  const SizedBox(height: 8),
                                  Text('Original post from ${mem.originalPost.authorName}:', style: Theme.of(context).textTheme.bodySmall),
                                  const SizedBox(height: 4),
                                  Text(mem.originalPost.content, maxLines: 2, overflow: TextOverflow.ellipsis),
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

/// Archive Screen (under More -> Your Activity)
class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Archive')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.archive_outlined, color: AppTheme.primary),
              title: const Text('Archived Posts'),
              subtitle: const Text('Posts hidden from your profile timeline'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Archived posts directory is current.')),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.chat_bubble_outline_rounded, color: AppTheme.primary),
              title: const Text('Archived Conversations'),
              subtitle: const Text('Direct and group message threads placed in storage'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Archived conversations loaded.')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

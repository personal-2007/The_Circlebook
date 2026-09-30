import 'package:flutter/material.dart';

import '../../../data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../../home/widgets/post_card.dart';

/// Saved Screen (under More -> Your Activity)
class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final savedPosts = MockData.posts.where((p) => p.isLiked || p.isSaved).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Posts & Links')),
      body: savedPosts.isEmpty
          ? const Center(child: Text('No saved items yet.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: savedPosts.length,
              itemBuilder: (context, index) {
                return PostCard(post: savedPosts[index]);
              },
            ),
    );
  }
}

/// Memories Screen (under More -> Your Activity)
class MemoriesScreen extends StatelessWidget {
  const MemoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memories')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.memories.length,
        itemBuilder: (context, index) {
          final mem = MockData.memories[index];
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

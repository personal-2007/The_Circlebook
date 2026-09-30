import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/circlebook_models.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({
    this.onPostCreated,
    super.key,
  });

  final ValueChanged<CirclePost>? onPostCreated;

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _contentController = TextEditingController();
  String _selectedAudience = 'Circles Only'; // 'Public', 'Circles Only', 'Only Me'
  final List<String> _selectedTags = ['#Community'];
  bool _hasMedia = false;

  final List<String> _availableTags = [
    '#Community',
    '#DesignSystems',
    '#Engineering',
    '#AI',
    '#Research',
    '#OpenSource',
  ];

  void _publishPost() {
    final text = _contentController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write some content before publishing.')),
      );
      return;
    }

    final newPost = CirclePost(
      id: 'post_${DateTime.now().millisecondsSinceEpoch}',
      authorId: MockData.currentUser.id,
      authorName: MockData.currentUser.name,
      authorHandle: MockData.currentUser.handle,
      authorAvatarUrl: MockData.currentUser.avatarUrl,
      timestamp: 'Just now',
      content: text,
      likes: 0,
      comments: 0,
      shares: 0,
      tags: List.from(_selectedTags),
      isLiked: false,
    );

    widget.onPostCreated?.call(newPost);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Post published to $_selectedAudience.')),
    );
    _contentController.clear();
    Navigator.of(context).pop();
  }

  void _showAudiencePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                  'Select Post Audience',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.public_rounded),
                title: const Text('Public'),
                subtitle: const Text('Visible to anyone inside and outside your circles'),
                trailing: _selectedAudience == 'Public' ? const Icon(Icons.check_rounded, color: Colors.blue) : null,
                onTap: () {
                  setState(() => _selectedAudience = 'Public');
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Icon(Icons.group_rounded),
                title: const Text('Circles Only'),
                subtitle: const Text('Visible only to your verified network and circles'),
                trailing: _selectedAudience == 'Circles Only' ? const Icon(Icons.check_rounded, color: Colors.blue) : null,
                onTap: () {
                  setState(() => _selectedAudience = 'Circles Only');
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Icon(Icons.lock_outline_rounded),
                title: const Text('Only Me (Draft / Private)'),
                subtitle: const Text('Only you can view this post'),
                trailing: _selectedAudience == 'Only Me' ? const Icon(Icons.check_rounded, color: Colors.blue) : null,
                onTap: () {
                  setState(() => _selectedAudience = 'Only Me');
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = MockData.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton(
              onPressed: _publishPost,
              child: const Text('Publish'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Author & Audience Selector
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Text(
                  user.name.split(' ').map((p) => p[0]).take(2).join(),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  InkWell(
                    borderRadius: BorderRadius.circular(6),
                    onTap: _showAudiencePicker,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: theme.dividerColor),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _selectedAudience == 'Public'
                                ? Icons.public_rounded
                                : _selectedAudience == 'Circles Only'
                                    ? Icons.group_rounded
                                    : Icons.lock_outline_rounded,
                            size: 13,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _selectedAudience,
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 3),
                          const Icon(Icons.arrow_drop_down, size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Content TextField
          TextField(
            controller: _contentController,
            maxLines: 8,
            minLines: 4,
            decoration: const InputDecoration(
              hintText: 'Share an insight, research question, or perspective...',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              fillColor: Colors.transparent,
              filled: false,
            ),
          ),

          if (_hasMedia) ...[
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.dividerColor),
              ),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image_outlined, size: 40, color: theme.colorScheme.primary),
                        const SizedBox(height: 6),
                        const Text('Attachment attached (sample_figure.png)', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: IconButton(
                      icon: const Icon(Icons.close_rounded, size: 20),
                      onPressed: () => setState(() => _hasMedia = false),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          const Divider(),
          const SizedBox(height: 12),

          // Tag Selector
          Text(
            'Add Topic Tags:',
            style: theme.textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _availableTags.map((tag) {
              final isSelected = _selectedTags.contains(tag);
              return FilterChip(
                label: Text(tag),
                selected: isSelected,
                onSelected: (val) {
                  setState(() {
                    if (val) {
                      _selectedTags.add(tag);
                    } else {
                      _selectedTags.remove(tag);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Attachment actions
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Text('Attach:'),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.image_outlined),
                    tooltip: 'Attach Image',
                    onPressed: () => setState(() => _hasMedia = !_hasMedia),
                  ),
                  IconButton(
                    icon: const Icon(Icons.poll_outlined),
                    tooltip: 'Create Poll',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Poll attachment module ready.')),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.article_outlined),
                    tooltip: 'Attach Article / PDF',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Document attachment selected.')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

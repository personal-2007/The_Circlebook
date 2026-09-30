import 'package:flutter/material.dart';

import '../../models/circlebook_models.dart';
import '../../repositories/post_repository.dart';
import '../../services/auth_service.dart';

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
  final PostRepository _postRepository = PostRepository();
  String _selectedAudience = 'Circles Only'; // 'Public', 'Circles Only', 'Only Me'
  final List<String> _selectedTags = ['#Community'];
  bool _hasMedia = false;
  bool _isPublishing = false;

  final List<String> _availableTags = [
    '#Community',
    '#DesignSystems',
    '#Engineering',
    '#AI',
    '#Research',
    '#OpenSource',
  ];

  Future<void> _publishPost() async {
    final text = _contentController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write some content before publishing.')),
      );
      return;
    }

    setState(() => _isPublishing = true);

    final user = AuthService.currentUser;
    final authorId = user?.id ?? 'usr_${DateTime.now().millisecondsSinceEpoch}';
    final authorName = user?.name ?? 'Member';
    final authorHandle = user?.handle ?? '@member';
    final authorAvatarUrl = user?.avatarUrl ?? '';

    final newPost = CirclePost(
      id: 'post_${DateTime.now().millisecondsSinceEpoch}',
      authorId: authorId,
      authorName: authorName,
      authorHandle: authorHandle,
      authorAvatarUrl: authorAvatarUrl,
      timestamp: 'Just now',
      content: text,
      likes: 0,
      comments: 0,
      shares: 0,
      tags: List.from(_selectedTags),
      isLiked: false,
    );

    try {
      await _postRepository.createPost(
        content: text,
        tags: List.from(_selectedTags),
        audience: _selectedAudience,
      );
    } catch (_) {
      // Allow optimistic UI update
    }

    if (!mounted) return;
    setState(() => _isPublishing = false);

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
    final user = AuthService.currentUser;
    final userName = user?.name ?? 'Member';
    final userHandle = user?.handle ?? '@member';
    final userInitials = userName.trim().split(RegExp(r'\s+')).map((p) => p.isNotEmpty ? p[0] : '').take(2).join().toUpperCase();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton(
              onPressed: _isPublishing ? null : _publishPost,
              child: _isPublishing
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Publish'),
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
                  userInitials.isNotEmpty ? userInitials : 'U',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          userHandle,
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: _showAudiencePicker,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
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
                                const SizedBox(width: 4),
                                Text(
                                  _selectedAudience,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Main text composer
          TextField(
            controller: _contentController,
            maxLines: 8,
            minLines: 4,
            decoration: const InputDecoration(
              hintText: 'What thoughts, papers, or observations would you like to share with your circle?',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              filled: false,
            ),
          ),
          const SizedBox(height: 16),

          // Topic / Tag selector chips
          Text(
            'Select Topics / Tags:',
            style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _availableTags.map((tag) {
              final isSelected = _selectedTags.contains(tag);
              return FilterChip(
                label: Text(tag, style: const TextStyle(fontSize: 12)),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedTags.add(tag);
                    } else {
                      _selectedTags.remove(tag);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Attached media preview
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
                        const Text('Attachment attached', style: TextStyle(fontSize: 12)),
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

          // Formatting & Media toolbar
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Text(
                    'Attach to post:',
                    style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.photo_library_outlined, size: 20),
                    tooltip: 'Add Image / Diagram',
                    onPressed: () {
                      setState(() => _hasMedia = !_hasMedia);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.link_rounded, size: 20),
                    tooltip: 'Insert Paper / DOI Link',
                    onPressed: () {
                      _contentController.text += ' https://';
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.tag_rounded, size: 20),
                    tooltip: 'Add Topic Tag',
                    onPressed: () {
                      _contentController.text += ' #';
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

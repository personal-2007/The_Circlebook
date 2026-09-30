import 'package:flutter/material.dart';

import '../../../models/circlebook_models.dart';
import '../../../theme/app_theme.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    required this.post,
    this.currentUserId = 'usr_001',
    this.onDelete,
    this.onHide,
    super.key,
  });

  final CirclePost post;
  final String currentUserId;
  final VoidCallback? onDelete;
  final VoidCallback? onHide;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool _isLiked;
  late int _likes;
  late bool _isSaved;
  late bool _notificationsOn;
  bool _isHidden = false;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.post.isLiked;
    _likes = widget.post.likes;
    _isSaved = widget.post.isSaved;
    _notificationsOn = widget.post.isNotificationsOn;
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likes += _isLiked ? 1 : -1;
    });
  }

  void _showCommentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => _CommentsSheet(postId: widget.post.id),
    );
  }

  void _showShareDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Share Post'),
        content: Text('Share "${widget.post.authorName}\'s post" with your circle or copy link:'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Post link copied to clipboard.')),
              );
            },
            icon: const Icon(Icons.link_rounded, size: 18),
            label: const Text('Copy Link'),
          ),
        ],
      ),
    );
  }

  void _handlePostMenuAction(String action) {
    switch (action) {
      case 'save':
        setState(() => _isSaved = !_isSaved);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_isSaved ? 'Post saved to Your Activity.' : 'Post removed from Saved.')),
        );
        break;
      case 'edit':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Edit post dialog opened.')),
        );
        break;
      case 'hide':
        setState(() => _isHidden = true);
        widget.onHide?.call();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post hidden from your feed.')),
        );
        break;
      case 'notifications':
        setState(() => _notificationsOn = !_notificationsOn);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_notificationsOn ? 'Notifications turned on for this post.' : 'Notifications turned off for this post.')),
        );
        break;
      case 'report':
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Report Post'),
            content: const Text('Thank you for helping keep Circlebook safe. Our Trust & Safety team will review this post according to Community Guidelines.'),
            actions: [
              FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('Submit Report')),
            ],
          ),
        );
        break;
      case 'delete':
        widget.onDelete?.call();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post deleted successfully.')),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isHidden) return const SizedBox.shrink();

    final isAuthor = widget.post.authorId == widget.currentUserId;
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Explainable algorithm recommendation banner
            if (widget.post.algorithmReason != null) ...[
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withAlpha(80),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome_rounded, size: 14, color: theme.colorScheme.primary),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        widget.post.algorithmReason!,
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Post Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Text(
                    widget.post.authorName.split(' ').map((p) => p[0]).take(2).join(),
                    style: TextStyle(
                      fontSize: 12,
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
                        widget.post.authorName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.5,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.post.authorHandle,
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '•  ${widget.post.timestamp}',
                            style: theme.textTheme.labelMedium?.copyWith(fontSize: 11.5),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Contextual Three-Dot Menu (Save, Edit, Hide, Turn off notifications, Report, Delete)
                Semantics(
                  label: 'Post options menu',
                  button: true,
                  child: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert_rounded, size: 20),
                    tooltip: 'Post options',
                    onSelected: _handlePostMenuAction,
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem<String>(
                        value: 'save',
                        child: Row(
                          children: [
                            Icon(_isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded, size: 18),
                            const SizedBox(width: 10),
                            Text(_isSaved ? 'Unsave Post' : 'Save Post'),
                          ],
                        ),
                      ),
                      if (isAuthor)
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined, size: 18),
                              SizedBox(width: 10),
                              Text('Edit Post'),
                            ],
                          ),
                        ),
                      const PopupMenuItem<String>(
                        value: 'hide',
                        child: Row(
                          children: [
                            Icon(Icons.visibility_off_outlined, size: 18),
                            SizedBox(width: 10),
                            Text('Hide from feed'),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'notifications',
                        child: Row(
                          children: [
                            Icon(_notificationsOn ? Icons.notifications_off_outlined : Icons.notifications_active_outlined, size: 18),
                            const SizedBox(width: 10),
                            Text(_notificationsOn ? 'Turn off notifications' : 'Turn on notifications'),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'report',
                        child: Row(
                          children: [
                            Icon(Icons.flag_outlined, size: 18, color: AppTheme.danger),
                            SizedBox(width: 10),
                            Text('Report Post', style: TextStyle(color: AppTheme.danger)),
                          ],
                        ),
                      ),
                      if (isAuthor)
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline_rounded, size: 18, color: AppTheme.danger),
                              SizedBox(width: 10),
                              Text('Delete Post', style: TextStyle(color: AppTheme.danger)),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Text(
              widget.post.content,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.45,
                fontSize: 14,
              ),
            ),

            if (widget.post.imageUrl != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: theme.colorScheme.surfaceContainerHighest,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_outlined, size: 36, color: theme.colorScheme.primary),
                      const SizedBox(height: 6),
                      Text(
                        'Attached Media',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: widget.post.tags.map((tag) {
                return Text(
                  tag,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 12),
            const Divider(),

            // Actions row: Like, Comment, Share
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Semantics(
                    label: _isLiked ? 'Unlike post' : 'Like post',
                    button: true,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: _toggleLike,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        child: Row(
                          children: [
                            Icon(
                              _isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              color: _isLiked ? Colors.red : theme.textTheme.bodySmall?.color,
                              size: 19,
                            ),
                            const SizedBox(width: 6),
                            Text('$_likes', style: theme.textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Semantics(
                    label: 'View comments',
                    button: true,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => _showCommentsBottomSheet(context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        child: Row(
                          children: [
                            Icon(
                              Icons.chat_bubble_outline_rounded,
                              size: 18,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                            const SizedBox(width: 6),
                            Text('${widget.post.comments}', style: theme.textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Semantics(
                    label: 'Share post',
                    button: true,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => _showShareDialog(context),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        child: Row(
                          children: [
                            Icon(
                              Icons.share_outlined,
                              size: 18,
                              color: theme.textTheme.bodySmall?.color,
                            ),
                            const SizedBox(width: 6),
                            Text('${widget.post.shares}', style: theme.textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Comment Bottom Sheet with contextual 3-dot menus for comments:
/// Contextual actions: Reply, Save, Report, Delete
class _CommentsSheet extends StatefulWidget {
  const _CommentsSheet({required this.postId});
  final String postId;

  @override
  State<_CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<_CommentsSheet> {
  final _commentController = TextEditingController();
  final List<CircleComment> _comments = [
    const CircleComment(
      id: 'c_1',
      postId: 'post_101',
      authorName: 'Priya Nair',
      authorHandle: '@priya_nair',
      content: 'I really love how calm the interface feels. No blinking distractions!',
      timestamp: '1h ago',
      likes: 5,
    ),
    const CircleComment(
      id: 'c_2',
      postId: 'post_101',
      authorName: 'Aarav Sharma',
      authorHandle: '@aarav_sharma',
      content: 'The user-controlled algorithm sorting is what makes it stand out for me.',
      timestamp: '45m ago',
      likes: 8,
      isAuthor: true,
    ),
  ];

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _comments.add(CircleComment(
        id: 'c_${DateTime.now().millisecondsSinceEpoch}',
        postId: widget.postId,
        authorName: 'Aarav Sharma',
        authorHandle: '@aarav_sharma',
        content: text,
        timestamp: 'Just now',
        isAuthor: true,
      ));
      _commentController.clear();
    });
  }

  void _handleCommentAction(String action, CircleComment comment) {
    switch (action) {
      case 'reply':
        _commentController.text = '${comment.authorHandle} ';
        break;
      case 'save':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Comment saved to your activity.')),
        );
        break;
      case 'report':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Comment reported to moderators.')),
        );
        break;
      case 'delete':
        setState(() {
          _comments.removeWhere((c) => c.id == comment.id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Comment deleted.')),
        );
        break;
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (ctx, scrollController) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 12,
          ),
          child: Column(
            children: [
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Comments (${_comments.length})',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.close_rounded, size: 20),
                    tooltip: 'Close comments',
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: _comments.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final c = _comments[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: theme.colorScheme.primaryContainer,
                            child: Text(
                              c.authorName[0],
                              style: TextStyle(fontSize: 11, color: theme.colorScheme.primary, fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      c.authorName,
                                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      c.timestamp,
                                      style: theme.textTheme.labelMedium?.copyWith(fontSize: 11),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(c.content, style: const TextStyle(fontSize: 13)),
                              ],
                            ),
                          ),
                          // Contextual 3-dot menu for comments (Reply, Save, Report, Delete)
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_horiz_rounded, size: 16),
                            tooltip: 'Comment actions',
                            onSelected: (val) => _handleCommentAction(val, c),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'reply',
                                child: Text('Reply'),
                              ),
                              const PopupMenuItem(
                                value: 'save',
                                child: Text('Save'),
                              ),
                              const PopupMenuItem(
                                value: 'report',
                                child: Text('Report', style: TextStyle(color: AppTheme.danger)),
                              ),
                              if (c.isAuthor)
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Delete', style: TextStyle(color: AppTheme.danger)),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          hintText: 'Add a thoughtful response...',
                          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: _addComment,
                      child: const Text('Post'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

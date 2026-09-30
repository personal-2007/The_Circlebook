import 'package:flutter/material.dart';

import '../../models/circlebook_models.dart';
import '../../repositories/message_repository.dart';
import '../../theme/app_theme.dart';
import '../../widgets/empty_state_view.dart';
import '../../widgets/error_state_view.dart';
import '../../widgets/loading_state_view.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final MessageRepository _messageRepository = MessageRepository();
  List<CircleMessage> _messages = [];
  bool _isLoading = true;
  String? _errorMessage;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final list = await _messageRepository.getMessages();
      if (mounted) {
        setState(() {
          _messages = list;
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

  void _handleMessageMenuAction(String action, CircleMessage msg) {
    switch (action) {
      case 'mute':
        final index = _messages.indexWhere((m) => m.id == msg.id);
        if (index != -1) {
          setState(() {
            _messages[index] = _messages[index].copyWith(isMuted: !_messages[index].isMuted);
          });
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg.isMuted ? 'Conversation unmuted.' : 'Conversation muted.')),
        );
        break;
      case 'search':
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Search in chat with ${msg.senderName}'),
            content: const TextField(
              decoration: InputDecoration(
                hintText: 'Type keyword to search in history...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
              FilledButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Search complete.')),
                  );
                },
                child: const Text('Search'),
              ),
            ],
          ),
        );
        break;
      case 'archive':
        setState(() {
          _messages.removeWhere((m) => m.id == msg.id);
        });
        _messageRepository.archiveConversation(msg.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Conversation with ${msg.senderName} archived.')),
        );
        break;
      case 'report':
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Report Conversation'),
            content: Text('Report messages from ${msg.senderName} for spam or harassment?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
              FilledButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Report submitted to Trust & Safety.')),
                  );
                },
                child: const Text('Submit Report'),
              ),
            ],
          ),
        );
        break;
    }
  }

  void _openConversation(CircleMessage message) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => _ChatDetailView(
          message: message,
          onMenuAction: (action) => _handleMessageMenuAction(action, message),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filtered = _messages.where((m) {
      if (_searchQuery.isEmpty) return true;
      final q = _searchQuery.toLowerCase();
      return m.senderName.toLowerCase().contains(q) ||
          m.handle.toLowerCase().contains(q) ||
          m.preview.toLowerCase().contains(q);
    }).toList();

    return RefreshIndicator(
      onRefresh: _loadMessages,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          // Search bar
          TextField(
            onChanged: (val) => setState(() => _searchQuery = val),
            decoration: InputDecoration(
              hintText: 'Search conversations...',
              prefixIcon: const Icon(Icons.search_rounded, size: 20),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 18),
                      onPressed: () => setState(() => _searchQuery = ''),
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 14),

          if (_isLoading)
            const LoadingStateView(message: 'Loading messages...')
          else if (_errorMessage != null)
            ErrorStateView(onRetry: _loadMessages)
          else if (filtered.isEmpty)
            EmptyStateView(
              title: 'No messages yet.',
              message: _searchQuery.isNotEmpty
                  ? 'No conversations found matching "$_searchQuery".'
                  : 'Direct conversations with your circles will appear here.',
              icon: Icons.chat_bubble_outline_rounded,
            )
          else ...[
            ...filtered.map((msg) {
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  onTap: () => _openConversation(msg),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: theme.colorScheme.primaryContainer,
                        child: Text(
                          msg.senderName.trim().isNotEmpty
                              ? msg.senderName.trim().split(RegExp(r'\s+')).map((p) => p[0]).take(2).join().toUpperCase()
                              : 'U',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      if (msg.isOnline)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 11,
                            height: 11,
                            decoration: BoxDecoration(
                              color: AppTheme.success,
                              shape: BoxShape.circle,
                              border: Border.all(color: theme.colorScheme.surface, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          msg.senderName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: msg.unread > 0 ? FontWeight.w800 : FontWeight.w600,
                            fontSize: 14.5,
                          ),
                        ),
                      ),
                      Text(
                        msg.time,
                        style: theme.textTheme.labelMedium?.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            msg.preview,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: msg.unread > 0 ? theme.textTheme.bodyLarge?.color : theme.textTheme.bodySmall?.color,
                              fontWeight: msg.unread > 0 ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ),
                        if (msg.unread > 0)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${msg.unread}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  trailing: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert_rounded, size: 18),
                    tooltip: 'Conversation options',
                    onSelected: (val) => _handleMessageMenuAction(val, msg),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'mute',
                        child: Row(
                          children: [
                            Icon(msg.isMuted ? Icons.volume_up_outlined : Icons.volume_off_outlined, size: 18),
                            const SizedBox(width: 10),
                            Text(msg.isMuted ? 'Unmute' : 'Mute'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'search',
                        child: Row(
                          children: [
                            Icon(Icons.search_rounded, size: 18),
                            SizedBox(width: 10),
                            Text('Search conversation'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'archive',
                        child: Row(
                          children: [
                            Icon(Icons.archive_outlined, size: 18),
                            SizedBox(width: 10),
                            Text('Archive'),
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
              );
            }),
          ],
        ],
      ),
    );
  }
}

class _ChatDetailView extends StatefulWidget {
  const _ChatDetailView({
    required this.message,
    required this.onMenuAction,
  });

  final CircleMessage message;
  final ValueChanged<String> onMenuAction;

  @override
  State<_ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<_ChatDetailView> {
  final _textController = TextEditingController();
  final List<String> _chatMessages = [];

  void _send() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _chatMessages.add(text);
      _textController.clear();
    });
    MessageRepository().sendMessage(widget.message.id, text);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Text(
                widget.message.senderName.trim().isNotEmpty
                    ? widget.message.senderName.trim().split(RegExp(r'\s+')).map((p) => p[0]).take(2).join().toUpperCase()
                    : 'U',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.message.senderName,
                  style: theme.textTheme.titleMedium?.copyWith(fontSize: 14.5, fontWeight: FontWeight.w700),
                ),
                Text(
                  widget.message.isOnline ? 'Online now' : widget.message.handle,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontSize: 11,
                    color: widget.message.isOnline ? AppTheme.success : null,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam_outlined),
            tooltip: 'Video consultation',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Video session request created.')),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: widget.onMenuAction,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'mute',
                child: Text(widget.message.isMuted ? 'Unmute' : 'Mute conversation'),
              ),
              const PopupMenuItem(value: 'search', child: Text('Search in conversation')),
              const PopupMenuItem(value: 'archive', child: Text('Archive conversation')),
              const PopupMenuItem(value: 'report', child: Text('Report sender', style: TextStyle(color: AppTheme.danger))),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _chatMessages.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'No messages yet. Send a message to start the conversation.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _chatMessages.length,
                    itemBuilder: (context, index) {
                      final text = _chatMessages[index];
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            text,
                            style: const TextStyle(color: Colors.white, fontSize: 13.5),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(top: BorderSide(color: theme.dividerColor)),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _send,
                    icon: const Icon(Icons.send_rounded, size: 18),
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

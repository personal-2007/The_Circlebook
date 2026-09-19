import 'package:flutter/material.dart';

import 'data/mock_data.dart';
import 'models/circlebook_models.dart';
import 'services/storage_service.dart';
import 'theme/app_theme.dart';

class CirclebookImage extends StatelessWidget {
  const CirclebookImage({
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.radius,
    this.borderRadius,
    this.child,
    this.label,
    super.key,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double? radius;
  final BorderRadius? borderRadius;
  final Widget? child;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: width,
      height: height,
      color: Theme.of(context).colorScheme.primaryContainer,
      alignment: Alignment.center,
      child: child ?? Text(label ?? '?', style: const TextStyle(fontWeight: FontWeight.w700)),
    );

    if (radius == null && borderRadius == null) {
      return placeholder;
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
      child: placeholder,
    );
  }
}

class TheCirclebookApp extends StatefulWidget {
  const TheCirclebookApp({super.key});

  @override
  State<TheCirclebookApp> createState() => _TheCirclebookAppState();
}

class _TheCirclebookAppState extends State<TheCirclebookApp> {
  ThemeMode _themeMode = StorageService.loadThemeMode();

  void _updateThemeMode(ThemeMode mode) {
    StorageService.saveThemeMode(mode);
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Circlebook',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: CirclebookShell(
        onThemeChanged: _updateThemeMode,
        themeMode: _themeMode,
      ),
    );
  }
}

class CirclebookShell extends StatefulWidget {
  const CirclebookShell({
    required this.onThemeChanged,
    required this.themeMode,
    super.key,
  });

  final ValueChanged<ThemeMode> onThemeChanged;
  final ThemeMode themeMode;

  @override
  State<CirclebookShell> createState() => _CirclebookShellState();
}

class _CirclebookShellState extends State<CirclebookShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    DiscoverScreen(),
    MessagesScreen(),
    NotificationsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primary, AppTheme.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.people_alt_rounded, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            const Text('The Circlebook'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              final nextMode = widget.themeMode == ThemeMode.dark
                  ? ThemeMode.light
                  : ThemeMode.dark;
              widget.onThemeChanged(nextMode);
            },
            icon: Icon(
              widget.themeMode == ThemeMode.dark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) => setState(() => _selectedIndex = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore_rounded), label: 'Discover'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline_rounded), selectedIcon: Icon(Icons.chat_bubble_rounded), label: 'Messages'),
          NavigationDestination(icon: Icon(Icons.notifications_none_rounded), selectedIcon: Icon(Icons.notifications_rounded), label: 'Alerts'),
          NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
        backgroundColor: colorScheme.surface,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = MockData.posts;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        _QuickActionsCard(),
        const SizedBox(height: 16),
        ...posts.map((post) => PostCard(post: post)),
      ],
    );
  }
}

class _QuickActionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      ('Share', Icons.edit_note_rounded),
      ('Groups', Icons.groups_rounded),
      ('Events', Icons.event_available_rounded),
      ('Career', Icons.work_outline_rounded),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Quick actions',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                const Icon(Icons.flash_on_rounded, color: AppTheme.accent),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: items
                  .map(
                    (item) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              Icon(item.$2, color: Theme.of(context).colorScheme.primary),
                              const SizedBox(height: 8),
                              Text(item.$1, style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        Text('People to meet', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: MockData.suggestedPeople
                .map((person) => SizedBox(
                      width: 170,
                      child: PersonCard(person: person),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: 24),
        Text('Communities', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        ...MockData.communities.map((community) => CommunityCard(community: community)),
        const SizedBox(height: 20),
        Text('Events', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        ...MockData.events.map((event) => EventCard(event: event)),
      ],
    );
  }
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        Text('Messages', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        ...MockData.messages.map((message) => MessageTile(message: message)),
      ],
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        Text('Notifications', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        ...MockData.notifications.map((item) => NotificationTile(notification: item)),
      ],
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockData.currentUser;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 42,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Text(
                    user.name.split(' ').map((part) => part[0]).take(2).join(),
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(height: 12),
                Text(user.name, style: Theme.of(context).textTheme.headlineSmall),
                Text(user.handle, style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 8),
                Text(user.headline, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _StatChip(label: 'Circles', value: '42'),
                    _StatChip(label: 'Posts', value: '128'),
                    _StatChip(label: 'Followers', value: '4.8K'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('About', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(user.about),
          ),
        ),
        const SizedBox(height: 16),
        Text('Skills', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: user.skills
              .map((skill) => Chip(label: Text(skill)))
              .toList(),
        ),
        const SizedBox(height: 20),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.settings_outlined),
          label: const Text('Settings'),
        ),
      ],
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({required this.post, super.key});

  final CirclePost post;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Text(
                    post.authorName.split(' ').map((part) => part[0]).take(2).join(),
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.authorName, style: const TextStyle(fontWeight: FontWeight.w700)),
                      Text(post.authorHandle, style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                    ],
                  ),
                ),
                Text(post.timestamp, style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
            const SizedBox(height: 12),
            Text(post.content),
            if (post.imageUrl != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: CirclebookImage(
                  url: post.imageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 220,
                  label: 'Post',
                  child: const Text('Post', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: post.tags.map((tag) => Text(tag, style: TextStyle(color: Theme.of(context).colorScheme.primary))).toList(),
            ),
            const SizedBox(height: 12),
            Divider(color: Theme.of(context).dividerColor.withAlpha(80)),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(post.isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded, color: post.isLiked ? Colors.red : null),
                ),
                Text('${post.likes}'),
                const SizedBox(width: 16),
                const Icon(Icons.chat_bubble_outline_rounded),
                const SizedBox(width: 6),
                Text('${post.comments}'),
                const Spacer(),
                const Icon(Icons.share_outlined),
                const SizedBox(width: 6),
                Text('${post.shares}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PersonCard extends StatelessWidget {
  const PersonCard({required this.person, super.key});

  final CircleUser person;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            CircleAvatar(
              radius: 34,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                person.name.split(' ').map((part) => part[0]).take(2).join(),
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 10),
            Text(person.name, style: Theme.of(context).textTheme.titleMedium),
            Text(person.headline, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
            const Spacer(),
            FilledButton.tonal(onPressed: () {}, child: const Text('Connect')),
          ],
        ),
      ),
    );
  }
}

class CommunityCard extends StatelessWidget {
  const CommunityCard({required this.community, super.key});

  final CircleCommunity community;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: CirclebookImage(
              url: community.bannerUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              label: community.name.substring(0, 1).toUpperCase(),
              child: Text(
                community.name.substring(0, 1).toUpperCase(),
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(community.name, style: Theme.of(context).textTheme.titleMedium)),
                    Text('${community.memberCount} members', style: Theme.of(context).textTheme.labelMedium),
                  ],
                ),
                const SizedBox(height: 8),
                Text(community.description),
                const SizedBox(height: 12),
                FilledButton.tonal(
                  onPressed: () {},
                  child: Text(community.isJoined ? 'Joined' : 'Join'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({required this.event, super.key});

  final CircleEvent event;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(18)),
            child: CirclebookImage(
              url: event.imageUrl,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
              label: event.title.substring(0, 1).toUpperCase(),
              child: Text(
                event.title.substring(0, 1).toUpperCase(),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 16),
                      const SizedBox(width: 8),
                      Text(event.date),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16),
                      const SizedBox(width: 8),
                      Expanded(child: Text(event.location)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('${event.attendees} attending'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile({required this.message, super.key});

  final CircleMessage message;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                message.senderName.split(' ').map((part) => part[0]).take(2).join(),
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
              ),
            ),
            if (message.isOnline)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Text(message.senderName),
        subtitle: Text(message.preview, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(message.time, style: Theme.of(context).textTheme.labelSmall),
            if (message.unread > 0)
              Container(
                margin: const EdgeInsets.only(top: 6),
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(message.unread.toString(), style: const TextStyle(fontSize: 10, color: Colors.white)),
              ),
          ],
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({required this.notification, super.key});

  final CircleNotification notification;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          notification.isUnread ? Icons.notifications_active_rounded : Icons.notifications_none_rounded,
          color: notification.isUnread ? AppTheme.primary : null,
        ),
        title: Text(notification.title),
        subtitle: Text(notification.detail),
        trailing: Text(notification.time, style: Theme.of(context).textTheme.labelSmall),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleMedium),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}

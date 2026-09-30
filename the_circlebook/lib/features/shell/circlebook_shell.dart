import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import '../create/create_post_screen.dart';
import '../discover/discover_screen.dart';
import '../home/home_screen.dart';
import '../messages/messages_screen.dart';
import '../more/more_screen.dart';
import '../notifications/notifications_screen.dart';
import '../people/people_screen.dart';
import '../profile/profile_screen.dart';
import '../search/search_screen.dart';
import '../settings/settings_screen.dart';
import 'widgets/profile_menu_sheet.dart';

class CirclebookShell extends StatefulWidget {
  const CirclebookShell({
    required this.onThemeChanged,
    required this.themeMode,
    this.initialIndex = 0,
    super.key,
  });

  final ValueChanged<ThemeMode> onThemeChanged;
  final ThemeMode themeMode;
  final int initialIndex;

  @override
  State<CirclebookShell> createState() => _CirclebookShellState();
}

class _CirclebookShellState extends State<CirclebookShell> {
  late int _mobileIndex;
  late int _desktopIndex;

  // Unread badge count for notifications
  int get _unreadNotificationCount =>
      MockData.notifications.where((n) => n.isUnread).length;

  @override
  void initState() {
    super.initState();
    _mobileIndex = widget.initialIndex.clamp(0, 4);
    _desktopIndex = widget.initialIndex.clamp(0, 6);
  }

  void _handleMobileTab(int index) {
    if (index == 2) {
      // Create is index 2 on mobile: open Create Post modal / screen
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => const CreatePostScreen(),
        ),
      );
      return;
    }
    setState(() => _mobileIndex = index);
  }

  void _handleDesktopTab(int index) {
    if (index == 7) {
      // More on desktop
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const MoreScreen()),
      );
      return;
    }
    setState(() => _desktopIndex = index);
  }

  Widget _getMobileBody() {
    switch (_mobileIndex) {
      case 0:
        return HomeScreen(
          onNavigateToCreate: () => _handleMobileTab(2),
        );
      case 1:
        return const PeopleScreen();
      case 2:
        return HomeScreen(
          onNavigateToCreate: () => _handleMobileTab(2),
        );
      case 3:
        return const MessagesScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  Widget _getDesktopBody() {
    switch (_desktopIndex) {
      case 0:
        return HomeScreen(
          onNavigateToCreate: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => const CreatePostScreen(),
              ),
            );
          },
        );
      case 1:
        return const PeopleScreen();
      case 2:
        return const DiscoverScreen();
      case 3:
        return const SearchScreen();
      case 4:
        return const MessagesScreen();
      case 5:
        return const NotificationsScreen();
      case 6:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  String _getMobileTitle() {
    switch (_mobileIndex) {
      case 0:
        return 'The Circlebook';
      case 1:
        return 'People & Circles';
      case 2:
        return 'The Circlebook';
      case 3:
        return 'Messages';
      case 4:
        return 'Profile';
      default:
        return 'The Circlebook';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = widget.themeMode == ThemeMode.dark ||
        (widget.themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktopOrTablet = constraints.maxWidth >= 720;

        if (isDesktopOrTablet) {
          // ==========================================
          // DESKTOP / TABLET PRIMARY NAVIGATION
          // Only: Home, People, Discover, Search, Messages, Notifications, Profile + More
          // ==========================================
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _desktopIndex,
                  onDestinationSelected: _handleDesktopTab,
                  labelType: NavigationRailLabelType.all,
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.primary, AppTheme.purple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.people_alt_rounded, color: Colors.white, size: 22),
                    ),
                  ),
                  trailing: Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: IconButton(
                          icon: Icon(
                            isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                            size: 20,
                          ),
                          tooltip: 'Toggle Theme',
                          onPressed: () {
                            widget.onThemeChanged(isDark ? ThemeMode.light : ThemeMode.dark);
                          },
                        ),
                      ),
                    ),
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home_rounded),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.people_outline_rounded),
                      selectedIcon: Icon(Icons.people_rounded),
                      label: Text('People'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.explore_outlined),
                      selectedIcon: Icon(Icons.explore_rounded),
                      label: Text('Discover'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.search_rounded),
                      selectedIcon: Icon(Icons.manage_search_rounded),
                      label: Text('Search'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.chat_bubble_outline_rounded),
                      selectedIcon: Icon(Icons.chat_bubble_rounded),
                      label: Text('Messages'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.notifications_none_rounded),
                      selectedIcon: Icon(Icons.notifications_rounded),
                      label: Text('Notifications'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline_rounded),
                      selectedIcon: Icon(Icons.person_rounded),
                      label: Text('Profile'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.grid_view_rounded),
                      selectedIcon: Icon(Icons.grid_view_rounded),
                      label: Text('More'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: Scaffold(
                    appBar: AppBar(
                      title: const Text('The Circlebook'),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline_rounded),
                          tooltip: 'Create Post',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (_) => const CreatePostScreen(),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings_outlined),
                          tooltip: 'Settings',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => SettingsScreen(
                                  onThemeModeChanged: widget.onThemeChanged,
                                  themeMode: widget.themeMode,
                                ),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () => ProfileMenuSheet.show(context),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: theme.colorScheme.primaryContainer,
                              child: Text(
                                'AS',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    body: _getDesktopBody(),
                  ),
                ),
              ],
            ),
          );
        }

        // ==========================================
        // MOBILE NAVIGATION
        // Bottom Navigation Bar MUST contain ONLY:
        // 1. Home
        // 2. People
        // 3. Create
        // 4. Messages
        // 5. Profile
        // Secondary items moved to More / AppBar
        // ==========================================
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primary, AppTheme.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(Icons.people_alt_rounded, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 10),
                Text(_getMobileTitle()),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search_rounded),
                tooltip: 'Search',
                onPressed: () => Navigator.of(context).pushNamed('/app/search'),
              ),
              IconButton(
                icon: Badge(
                  isLabelVisible: _unreadNotificationCount > 0,
                  label: Text('$_unreadNotificationCount'),
                  child: const Icon(Icons.notifications_none_rounded),
                ),
                tooltip: 'Notifications',
                onPressed: () => Navigator.of(context).pushNamed('/app/notifications'),
              ),
              IconButton(
                icon: const Icon(Icons.grid_view_rounded),
                tooltip: 'More Menu',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MoreScreen()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 4),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => ProfileMenuSheet.show(context),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Text(
                      'AS',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: _getMobileBody(),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _mobileIndex,
            onDestinationSelected: _handleMobileTab,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.people_outline_rounded),
                selectedIcon: Icon(Icons.people_rounded),
                label: 'People',
              ),
              NavigationDestination(
                icon: Icon(Icons.add_circle_outline_rounded),
                selectedIcon: Icon(Icons.add_circle_rounded),
                label: 'Create',
              ),
              NavigationDestination(
                icon: Icon(Icons.chat_bubble_outline_rounded),
                selectedIcon: Icon(Icons.chat_bubble_rounded),
                label: 'Messages',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}

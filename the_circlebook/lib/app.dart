import 'package:flutter/material.dart';

import 'features/auth/login_screen.dart';
import 'features/auth/signup_screen.dart';
import 'features/auth/verification_screen.dart';
import 'features/auth/welcome_screen.dart';
import 'features/create/create_post_screen.dart';
import 'features/discover/discover_screen.dart';
import 'features/more/more_screen.dart';
import 'features/more/subscreens/activity_subscreens.dart';
import 'features/more/subscreens/explore_subscreens.dart';
import 'features/more/subscreens/intelligence_subscreens.dart';
import 'features/more/subscreens/tools_subscreens.dart';
import 'features/notifications/notifications_screen.dart';
import 'features/search/search_screen.dart';
import 'features/settings/account_settings_view.dart';
import 'features/settings/appearance_settings_view.dart';
import 'features/settings/notifications_settings_view.dart';
import 'features/settings/personalization_settings_view.dart';
import 'features/settings/privacy_settings_view.dart';
import 'features/settings/security_settings_view.dart';
import 'features/settings/settings_screen.dart';
import 'features/settings/support_settings_view.dart';
import 'features/shell/circlebook_shell.dart';
import 'features/splash/splash_screen.dart';
import 'services/storage_service.dart';
import 'theme/app_theme.dart';

// Re-export for modular imports
export 'features/create/create_post_screen.dart';
export 'features/discover/discover_screen.dart';
export 'features/home/home_screen.dart';
export 'features/home/widgets/post_card.dart';
export 'features/messages/messages_screen.dart';
export 'features/more/more_screen.dart';
export 'features/notifications/notifications_screen.dart';
export 'features/people/people_screen.dart';
export 'features/profile/profile_screen.dart';
export 'features/search/search_screen.dart';
export 'features/settings/settings_screen.dart';
export 'features/shell/circlebook_shell.dart';
export 'features/splash/splash_screen.dart';

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
  const TheCirclebookApp({
    this.initialRoute = '/app',
    super.key,
  });

  final String initialRoute;

  @override
  State<TheCirclebookApp> createState() => _TheCirclebookAppState();
}

class _TheCirclebookAppState extends State<TheCirclebookApp> {
  ThemeMode _themeMode = StorageService.loadThemeMode();
  bool _highContrast = StorageService.loadHighContrast();
  double _textScale = StorageService.loadTextScale();

  void _updateThemeMode(ThemeMode mode) {
    StorageService.saveThemeMode(mode);
    setState(() {
      _themeMode = mode;
    });
  }

  void _reloadAccessibility() {
    setState(() {
      _highContrast = StorageService.loadHighContrast();
      _textScale = StorageService.loadTextScale();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Circlebook',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: AppTheme.light(highContrast: _highContrast),
      darkTheme: AppTheme.dark(highContrast: _highContrast),
      initialRoute: widget.initialRoute,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(_textScale),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      routes: {
        '/': (context) => const SplashScreen(),
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/auth/login': (context) => const LoginScreen(),
        '/auth/signup': (context) => const SignupScreen(),
        '/auth/verification': (context) => const VerificationScreen(),
        '/app': (context) => CirclebookShell(
              onThemeChanged: _updateThemeMode,
              themeMode: _themeMode,
              initialIndex: 0,
            ),
        '/app/home': (context) => CirclebookShell(
              onThemeChanged: _updateThemeMode,
              themeMode: _themeMode,
              initialIndex: 0,
            ),
        '/app/people': (context) => CirclebookShell(
              onThemeChanged: _updateThemeMode,
              themeMode: _themeMode,
              initialIndex: 1,
            ),
        '/app/create': (context) => const CreatePostScreen(),
        '/app/messages': (context) => CirclebookShell(
              onThemeChanged: _updateThemeMode,
              themeMode: _themeMode,
              initialIndex: 3,
            ),
        '/app/profile': (context) => CirclebookShell(
              onThemeChanged: _updateThemeMode,
              themeMode: _themeMode,
              initialIndex: 4,
            ),
        '/app/discover': (context) => Scaffold(
              appBar: AppBar(title: const Text('Discover')),
              body: const DiscoverScreen(),
            ),
        '/app/search': (context) => const SearchScreen(),
        '/app/notifications': (context) => const NotificationsScreen(),
        '/app/more': (context) => const MoreScreen(),
        '/app/more/groups': (context) => const GroupsScreen(),
        '/app/more/events': (context) => const EventsScreen(),
        '/app/more/watch': (context) => const WatchScreen(),
        '/app/more/marketplace': (context) => const MarketplaceScreen(),
        '/app/more/saved': (context) => const SavedScreen(),
        '/app/more/memories': (context) => const MemoriesScreen(),
        '/app/more/archive': (context) => const ArchiveScreen(),
        '/app/more/creator-tools': (context) => const CreatorToolsScreen(),
        '/app/more/analytics': (context) => const AnalyticsScreen(),
        '/app/more/ai': (context) => const CircleAIScreen(),
        '/app/settings': (context) => SettingsScreen(
              onThemeModeChanged: _updateThemeMode,
              themeMode: _themeMode,
              onAccessibilityChanged: _reloadAccessibility,
            ),
        '/app/settings/account': (context) => const AccountSettingsView(),
        '/app/settings/privacy': (context) => const PrivacySettingsView(),
        '/app/settings/security': (context) => const SecuritySettingsView(),
        '/app/settings/notifications': (context) => const NotificationsSettingsView(),
        '/app/settings/appearance': (context) => AppearanceSettingsView(
              onThemeModeChanged: _updateThemeMode,
              themeMode: _themeMode,
              onAccessibilityChanged: _reloadAccessibility,
            ),
        '/app/settings/personalization': (context) => const PersonalizationSettingsView(),
        '/app/settings/support': (context) => const SupportSettingsView(),
      },
    );
  }
}

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
    this.home,
    this.initialRoute,
    super.key,
  });

  final Widget? home;
  final String? initialRoute;

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
      home: widget.home ??
          CirclebookShell(
            onThemeChanged: _updateThemeMode,
            themeMode: _themeMode,
            initialIndex: 0,
          ),
      initialRoute: widget.initialRoute,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(_textScale),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
          case '/splash':
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case '/welcome':
            return MaterialPageRoute(builder: (_) => const WelcomeScreen());
          case '/auth/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/auth/signup':
            return MaterialPageRoute(builder: (_) => const SignupScreen());
          case '/auth/verification':
            return MaterialPageRoute(builder: (_) => const VerificationScreen());
          case '/app':
          case '/app/home':
            return MaterialPageRoute(
              builder: (_) => CirclebookShell(
                onThemeChanged: _updateThemeMode,
                themeMode: _themeMode,
                initialIndex: 0,
              ),
            );
          case '/app/people':
            return MaterialPageRoute(
              builder: (_) => CirclebookShell(
                onThemeChanged: _updateThemeMode,
                themeMode: _themeMode,
                initialIndex: 1,
              ),
            );
          case '/app/create':
            return MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => const CreatePostScreen(),
            );
          case '/app/messages':
            return MaterialPageRoute(
              builder: (_) => CirclebookShell(
                onThemeChanged: _updateThemeMode,
                themeMode: _themeMode,
                initialIndex: 3,
              ),
            );
          case '/app/profile':
            return MaterialPageRoute(
              builder: (_) => CirclebookShell(
                onThemeChanged: _updateThemeMode,
                themeMode: _themeMode,
                initialIndex: 4,
              ),
            );
          case '/app/discover':
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(title: const Text('Discover')),
                body: const DiscoverScreen(),
              ),
            );
          case '/app/search':
            return MaterialPageRoute(builder: (_) => const SearchScreen());
          case '/app/notifications':
            return MaterialPageRoute(builder: (_) => const NotificationsScreen());
          case '/app/more':
            return MaterialPageRoute(builder: (_) => const MoreScreen());
          case '/app/more/groups':
            return MaterialPageRoute(builder: (_) => const GroupsScreen());
          case '/app/more/events':
            return MaterialPageRoute(builder: (_) => const EventsScreen());
          case '/app/more/watch':
            return MaterialPageRoute(builder: (_) => const WatchScreen());
          case '/app/more/marketplace':
            return MaterialPageRoute(builder: (_) => const MarketplaceScreen());
          case '/app/more/saved':
            return MaterialPageRoute(builder: (_) => const SavedScreen());
          case '/app/more/memories':
            return MaterialPageRoute(builder: (_) => const MemoriesScreen());
          case '/app/more/archive':
            return MaterialPageRoute(builder: (_) => const ArchiveScreen());
          case '/app/more/creator-tools':
            return MaterialPageRoute(builder: (_) => const CreatorToolsScreen());
          case '/app/more/analytics':
            return MaterialPageRoute(builder: (_) => const AnalyticsScreen());
          case '/app/more/ai':
            return MaterialPageRoute(builder: (_) => const CircleAIScreen());
          case '/app/settings':
            return MaterialPageRoute(
              builder: (_) => SettingsScreen(
                onThemeModeChanged: _updateThemeMode,
                themeMode: _themeMode,
                onAccessibilityChanged: _reloadAccessibility,
              ),
            );
          case '/app/settings/account':
            return MaterialPageRoute(builder: (_) => const AccountSettingsView());
          case '/app/settings/privacy':
            return MaterialPageRoute(builder: (_) => const PrivacySettingsView());
          case '/app/settings/security':
            return MaterialPageRoute(builder: (_) => const SecuritySettingsView());
          case '/app/settings/notifications':
            return MaterialPageRoute(builder: (_) => const NotificationsSettingsView());
          case '/app/settings/appearance':
            return MaterialPageRoute(
              builder: (_) => AppearanceSettingsView(
                onThemeModeChanged: _updateThemeMode,
                themeMode: _themeMode,
                onAccessibilityChanged: _reloadAccessibility,
              ),
            );
          case '/app/settings/personalization':
            return MaterialPageRoute(builder: (_) => const PersonalizationSettingsView());
          case '/app/settings/support':
            return MaterialPageRoute(builder: (_) => const SupportSettingsView());
          default:
            return MaterialPageRoute(
              builder: (_) => CirclebookShell(
                onThemeChanged: _updateThemeMode,
                themeMode: _themeMode,
                initialIndex: 0,
              ),
            );
        }
      },
    );
  }
}

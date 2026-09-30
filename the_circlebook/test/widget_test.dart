import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:the_circlebook/app.dart';

class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  setUpAll(() {
    HttpOverrides.global = _TestHttpOverrides();
  });

  testWidgets('The Circlebook app renders the desktop/tablet shell by default in 800x600', (tester) async {
    await tester.pumpWidget(const TheCirclebookApp());

    expect(find.text('The Circlebook'), findsWidgets);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Discover'), findsOneWidget);
    expect(find.text('People'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Messages'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('More'), findsOneWidget);
  });

  testWidgets('Mobile Bottom Navigation displays ONLY essential 5 items', (tester) async {
    // Set viewport to standard phone dimensions (400 x 800)
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const TheCirclebookApp());
    await tester.pump();

    // Verify exactly the 5 required bottom navigation items
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('People'), findsOneWidget);
    expect(find.text('Create'), findsOneWidget);
    expect(find.text('Messages'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    // Verify secondary features are NOT in the mobile bottom navigation
    final bottomNav = find.byType(NavigationBar);
    expect(bottomNav, findsOneWidget);

    expect(find.descendant(of: bottomNav, matching: find.text('Groups')), findsNothing);
    expect(find.descendant(of: bottomNav, matching: find.text('Events')), findsNothing);
    expect(find.descendant(of: bottomNav, matching: find.text('Watch')), findsNothing);
    expect(find.descendant(of: bottomNav, matching: find.text('Marketplace')), findsNothing);
    expect(find.descendant(of: bottomNav, matching: find.text('Saved')), findsNothing);
    expect(find.descendant(of: bottomNav, matching: find.text('Memories')), findsNothing);
    expect(find.descendant(of: bottomNav, matching: find.text('Analytics')), findsNothing);
    expect(find.descendant(of: bottomNav, matching: find.text('Creator Tools')), findsNothing);
    expect(find.descendant(of: bottomNav, matching: find.text('AI Tools')), findsNothing);
    expect(find.descendant(of: bottomNav, matching: find.text('Settings')), findsNothing);
    expect(find.descendant(of: bottomNav, matching: find.text('Security')), findsNothing);
    expect(find.descendant(of: bottomNav, matching: find.text('Help')), findsNothing);
  });

  testWidgets('More Menu organizes secondary features into 6 required sections', (tester) async {
    tester.view.physicalSize = const Size(800, 2200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MaterialApp(
      home: MoreScreen(),
    ));

    // Section 1: Explore
    expect(find.text('EXPLORE'), findsOneWidget);
    expect(find.text('Groups'), findsOneWidget);
    expect(find.text('Events'), findsOneWidget);
    expect(find.text('Watch'), findsOneWidget);
    expect(find.text('Marketplace'), findsOneWidget);

    // Section 2: Your Activity
    expect(find.text('YOUR ACTIVITY'), findsOneWidget);
    expect(find.text('Saved'), findsOneWidget);
    expect(find.text('Memories'), findsOneWidget);
    expect(find.text('Archive'), findsOneWidget);

    // Section 3: Tools
    expect(find.text('TOOLS'), findsOneWidget);
    expect(find.text('Creator Tools'), findsOneWidget);
    expect(find.text('Professional Tools'), findsOneWidget);
    expect(find.text('Analytics'), findsOneWidget);

    // Section 4: Intelligence
    expect(find.text('INTELLIGENCE'), findsOneWidget);
    expect(find.text('Circle AI'), findsOneWidget);
    expect(find.text('Smart Search'), findsOneWidget);
    expect(find.text('Recommendations Control'), findsOneWidget);

    // Section 5: Support
    expect(find.text('SUPPORT'), findsOneWidget);
    expect(find.text('Help & Support'), findsOneWidget);
    expect(find.text('Report a Problem'), findsOneWidget);

    // Section 6: Account
    expect(find.text('ACCOUNT'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('Settings screen contains all 8 required account-level sections', (tester) async {
    tester.view.physicalSize = const Size(800, 2200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(MaterialApp(
      home: SettingsScreen(
        onThemeModeChanged: (_) {},
        themeMode: ThemeMode.system,
      ),
    ));

    expect(find.text('ACCOUNT'), findsOneWidget);
    expect(find.text('Account Information'), findsOneWidget);

    expect(find.text('PRIVACY'), findsOneWidget);
    expect(find.text('Privacy Controls'), findsOneWidget);

    expect(find.text('SECURITY'), findsOneWidget);
    expect(find.text('Security & Authentication'), findsOneWidget);

    expect(find.text('NOTIFICATIONS'), findsOneWidget);
    expect(find.text('Notification Preferences'), findsOneWidget);

    expect(find.text('APPEARANCE'), findsOneWidget);
    expect(find.text('Theme & Accessibility'), findsOneWidget);

    expect(find.text('DATA & PERSONALIZATION'), findsOneWidget);
    expect(find.text('Personalization & Algorithms'), findsOneWidget);

    expect(find.text('Support & Policies'), findsNothing); // section header is SUPPORT
    expect(find.text('SUPPORT'), findsOneWidget);
    expect(find.text('Help, Guidelines & Policies'), findsOneWidget);

    expect(find.text('ACCOUNT EXIT'), findsOneWidget);
    expect(find.text('Log Out'), findsOneWidget);
    expect(find.text('Deactivate Account'), findsOneWidget);
    expect(find.text('Delete Account'), findsOneWidget);
  });

  testWidgets('Posts have contextual 3-dot menus and user-controlled feed algorithm', (tester) async {
    await tester.pumpWidget(const TheCirclebookApp());

    // User-controlled algorithm chips
    expect(find.text('Relevant (For You)'), findsOneWidget);
    expect(find.text('Chronological'), findsOneWidget);
    expect(find.text('Close Circles'), findsOneWidget);

    // Contextual 3-dot post options button exists
    final postOptionsFinder = find.byTooltip('Post options');
    expect(postOptionsFinder, findsWidgets);

    // Tap the first post 3-dot menu
    await tester.tap(postOptionsFinder.first);
    await tester.pumpAndSettle();

    // Verify contextual options: Save, Hide, Turn off notifications, Report
    expect(find.text('Save Post'), findsOneWidget);
    expect(find.text('Hide from feed'), findsOneWidget);
    expect(find.text('Turn off notifications'), findsOneWidget);
    expect(find.text('Report Post'), findsOneWidget);
  });
}

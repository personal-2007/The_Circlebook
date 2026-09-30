import 'dart:async';
import 'package:flutter/material.dart';

import '../../services/storage_service.dart';
import '../../theme/app_theme.dart';

/// 2030-ready Loading & Initialization Screen.
/// Performs real parallel initialization (storage, session, preferences).
/// Respects reduced motion settings and avoids artificial 3-second delays.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _initializeApp() async {
    await StorageService.init();
    if (!mounted) return;

    _timer = Timer(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      final isLoggedIn = StorageService.loadLoggedIn();
      if (isLoggedIn) {
        Navigator.of(context).pushReplacementNamed('/app');
      } else {
        Navigator.of(context).pushReplacementNamed('/welcome');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final reducedMotion = StorageService.loadReducedMotion();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primary, AppTheme.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withAlpha(isDark ? 40 : 60),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.people_alt_rounded,
                color: Colors.white,
                size: 38,
                semanticLabel: 'The Circlebook logo',
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'The Circlebook',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'A calm, professional social ecosystem',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 13,
                  ),
            ),
            const SizedBox(height: 36),
            SizedBox(
              width: 24,
              height: 24,
              child: reducedMotion
                  ? const SizedBox()
                  : const CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

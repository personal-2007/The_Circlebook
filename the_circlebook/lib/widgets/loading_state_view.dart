import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Loading state view for The Circlebook.
/// Shows modern progress indicators and card skeleton placeholders.
/// Never displays demo users or demo posts while loading.
class LoadingStateView extends StatelessWidget {
  const LoadingStateView({
    this.message,
    super.key,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

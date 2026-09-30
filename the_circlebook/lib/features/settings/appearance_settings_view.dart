import 'package:flutter/material.dart';

import '../../services/storage_service.dart';
import '../../theme/app_theme.dart';

class AppearanceSettingsView extends StatefulWidget {
  const AppearanceSettingsView({
    required this.onThemeModeChanged,
    required this.themeMode,
    this.onAccessibilityChanged,
    super.key,
  });

  final ValueChanged<ThemeMode> onThemeModeChanged;
  final ThemeMode themeMode;
  final VoidCallback? onAccessibilityChanged;

  @override
  State<AppearanceSettingsView> createState() => _AppearanceSettingsViewState();
}

class _AppearanceSettingsViewState extends State<AppearanceSettingsView> {
  late ThemeMode _currentMode;
  late bool _reducedMotion;
  late bool _highContrast;
  late double _textScale;

  @override
  void initState() {
    super.initState();
    _currentMode = widget.themeMode;
    _reducedMotion = StorageService.loadReducedMotion();
    _highContrast = StorageService.loadHighContrast();
    _textScale = StorageService.loadTextScale();
  }

  void _updateMode(ThemeMode mode) {
    setState(() => _currentMode = mode);
    widget.onThemeModeChanged(mode);
  }

  void _toggleReducedMotion(bool val) {
    setState(() => _reducedMotion = val);
    StorageService.saveReducedMotion(val);
    widget.onAccessibilityChanged?.call();
  }

  void _toggleHighContrast(bool val) {
    setState(() => _highContrast = val);
    StorageService.saveHighContrast(val);
    widget.onAccessibilityChanged?.call();
  }

  void _updateTextScale(double scale) {
    setState(() => _textScale = scale);
    StorageService.saveTextScale(scale);
    widget.onAccessibilityChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appearance & Accessibility')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme Mode Selection
          Text('Theme Palette', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                RadioListTile<ThemeMode>(
                  secondary: const Icon(Icons.wb_sunny_outlined, color: AppTheme.warning),
                  title: const Text('Light'),
                  subtitle: const Text('Crisp white background with classical typography'),
                  value: ThemeMode.light,
                  groupValue: _currentMode,
                  onChanged: (val) => _updateMode(val!),
                ),
                const Divider(height: 1),
                RadioListTile<ThemeMode>(
                  secondary: const Icon(Icons.nightlight_outlined, color: AppTheme.purple),
                  title: const Text('Dark'),
                  subtitle: const Text('Deep navy slate with high-contrast text'),
                  value: ThemeMode.dark,
                  groupValue: _currentMode,
                  onChanged: (val) => _updateMode(val!),
                ),
                const Divider(height: 1),
                RadioListTile<ThemeMode>(
                  secondary: const Icon(Icons.brightness_auto_outlined, color: AppTheme.primary),
                  title: const Text('System Default'),
                  subtitle: const Text('Synchronize with device appearance'),
                  value: ThemeMode.system,
                  groupValue: _currentMode,
                  onChanged: (val) => _updateMode(val!),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Typography & Scaling
          Text('Typography & Scaling', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Text Scale Factor', style: TextStyle(fontWeight: FontWeight.w600)),
                      Text('${(_textScale * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.primary)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Slider(
                    value: _textScale,
                    min: 0.85,
                    max: 1.35,
                    divisions: 5,
                    onChanged: _updateTextScale,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Preview text scaling: The Circlebook provides human-first readability.',
                    style: TextStyle(fontSize: 13.5 * _textScale),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Accessibility
          Text('Accessibility (2030 Standard)', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.motion_photos_off_rounded, color: AppTheme.primary),
                  title: const Text('Reduced Motion'),
                  subtitle: const Text('Disables transition parallax, fades, and animations for reduced motion preference'),
                  value: _reducedMotion,
                  onChanged: _toggleReducedMotion,
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.contrast_rounded, color: AppTheme.secondary),
                  title: const Text('High Contrast Outlines'),
                  subtitle: const Text('Strengthens borders and text contrast for enhanced legibility'),
                  value: _highContrast,
                  onChanged: _toggleHighContrast,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  // Theme Mode
  static Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    _preferences = prefs;
    await prefs.setString('theme_mode', mode.name);
  }

  static ThemeMode loadThemeMode() {
    final prefs = _preferences;
    if (prefs == null) return ThemeMode.system;
    final modeName = prefs.getString('theme_mode');
    switch (modeName) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  // Accessibility: Reduced Motion
  static Future<void> saveReducedMotion(bool enabled) async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    _preferences = prefs;
    await prefs.setBool('reduced_motion', enabled);
  }

  static bool loadReducedMotion() {
    return _preferences?.getBool('reduced_motion') ?? false;
  }

  // Accessibility: High Contrast
  static Future<void> saveHighContrast(bool enabled) async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    _preferences = prefs;
    await prefs.setBool('high_contrast', enabled);
  }

  static bool loadHighContrast() {
    return _preferences?.getBool('high_contrast') ?? false;
  }

  // Accessibility: Text Scale
  static Future<void> saveTextScale(double scale) async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    _preferences = prefs;
    await prefs.setDouble('text_scale', scale);
  }

  static double loadTextScale() {
    return _preferences?.getDouble('text_scale') ?? 1.0;
  }

  // Auth / Session
  static Future<void> saveLoggedIn(bool loggedIn) async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    _preferences = prefs;
    await prefs.setBool('is_logged_in', loggedIn);
  }

  static bool loadLoggedIn() {
    // Default to true for existing active session experience
    return _preferences?.getBool('is_logged_in') ?? true;
  }

  // Feed Algorithm Preference: 'for_you' (Relevant), 'following' (Chronological), 'circles'
  static Future<void> saveFeedAlgorithm(String algo) async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    _preferences = prefs;
    await prefs.setString('feed_algorithm', algo);
  }

  static String loadFeedAlgorithm() {
    return _preferences?.getString('feed_algorithm') ?? 'for_you';
  }

  // Saved Posts
  static Future<void> saveSavedPostIds(List<String> ids) async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    _preferences = prefs;
    await prefs.setStringList('saved_post_ids', ids);
  }

  static List<String> loadSavedPostIds() {
    return _preferences?.getStringList('saved_post_ids') ?? [];
  }

  // Blocked Users
  static Future<void> saveBlockedUserIds(List<String> ids) async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    _preferences = prefs;
    await prefs.setStringList('blocked_user_ids', ids);
  }

  static List<String> loadBlockedUserIds() {
    return _preferences?.getStringList('blocked_user_ids') ?? [];
  }

  // Clear session data on logout
  static Future<void> logout() async {
    await saveLoggedIn(false);
  }
}

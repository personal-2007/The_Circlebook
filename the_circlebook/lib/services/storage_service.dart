import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/circlebook_models.dart';

/// StorageService manages persistent device state (preferences, tokens, local settings).
/// Production data is NOT stored here; this layer only holds user session and UI preferences.
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

  // Auth Session & JWT Token
  static Future<void> saveAuthToken(String token) async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    _preferences = prefs;
    await prefs.setString('auth_token', token);
    await prefs.setBool('is_logged_in', true);
  }

  static String? loadAuthToken() {
    return _preferences?.getString('auth_token');
  }

  static Future<void> clearAuthToken() async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    _preferences = prefs;
    await prefs.remove('auth_token');
    await prefs.setBool('is_logged_in', false);
  }

  static Future<void> saveCurrentUser(CircleUser user) async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    _preferences = prefs;
    await prefs.setString('current_user_profile', jsonEncode(user.toJson()));
  }

  static CircleUser? loadCurrentUser() {
    final data = _preferences?.getString('current_user_profile');
    if (data == null || data.isEmpty) return null;
    try {
      final json = jsonDecode(data) as Map<String, dynamic>;
      return CircleUser.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  static Future<void> saveLoggedIn(bool loggedIn) async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    _preferences = prefs;
    await prefs.setBool('is_logged_in', loggedIn);
  }

  static bool loadLoggedIn() {
    // Default to false. Only returns true if an active token or session flag exists.
    final hasToken = _preferences?.getString('auth_token')?.isNotEmpty ?? false;
    final flag = _preferences?.getBool('is_logged_in') ?? false;
    return hasToken || flag;
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

  // Saved Posts IDs
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
    await clearAuthToken();
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    await prefs.remove('current_user_profile');
    await prefs.setBool('is_logged_in', false);
  }
}

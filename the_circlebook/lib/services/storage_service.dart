import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class StorageService {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    _preferences = prefs;
    await prefs.setString('theme_mode', mode.name);
  }

  static ThemeMode loadThemeMode() {
    final prefs = _preferences;
    if (prefs == null) {
      return ThemeMode.system;
    }

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
}

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// App Theme service
class AppThemeService {
  /// Instance of [SharedPreferences]
  final SharedPreferences sharedPreferences;

  /// App theme mode. Can be [ThemeMode.light], [ThemeMode.dark] or [ThemeMode.system]
  ThemeMode themeMode;

  /// App Theme service
  AppThemeService(this.sharedPreferences, {this.themeMode = ThemeMode.system});

  /// Change app theme
  Future<void> changeTheme(ThemeMode mode) async {
    await sharedPreferences.setInt('themeMode', mode.toInt());

    themeMode = mode;
  }
}

/// Helper extension methods to easily get theme mode from an integer.
extension GetThemeFromInt on int {
  /// [int] to [ThemeMode]. Opposite of [ThemeMode.toInt]
  ThemeMode toThemeMode() {
    switch (this) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

/// Helper extension methods for [ThemeMode]
extension ThemeModeUtils on ThemeMode {
  /// [ThemeMode] to [int]. Opposite of [int.toThemeMode]
  int toInt() {
    switch (this) {
      case ThemeMode.system:
        return 0;
      case ThemeMode.light:
        return 1;
      case ThemeMode.dark:
        return 2;
      default:
        return 0;
    }
  }

  /// Get mode name
  String name() {
    switch (this) {
      case ThemeMode.system:
        return "System";
      case ThemeMode.light:
        return "Light";
      case ThemeMode.dark:
        return "Dark";
      default:
        return "System";
    }
  }
}

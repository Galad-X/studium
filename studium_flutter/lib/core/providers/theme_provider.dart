import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// The Notifier that manages the theme state
class ThemeNotifier extends StateNotifier<ThemeMode> {
  // We can initialize it with the system's default theme.
  ThemeNotifier() : super(ThemeMode.system) {
    // In a real app, you would load the saved theme preference here.
    // E.g., _loadThemeFromPrefs();
  }

  void setTheme(ThemeMode themeMode) {
    if (state != themeMode) {
      state = themeMode;
      // In a real app, you would save the preference here.
      // E.g., _saveThemeToPrefs(themeMode);
    }
  }
}

// The Provider that exposes the ThemeNotifier to the app.
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

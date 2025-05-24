import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme_changer_erfan/dynamic_theme_picker.dart';
import 'package:portfolio_erfanalizada/interfaces/theme_toggle_interface.dart';

class ThemeToggleManager implements ThemeToggleInterface {
  // Singleton pattern
  static final ThemeToggleManager _instance = ThemeToggleManager._internal();
  
  factory ThemeToggleManager() {
    return _instance;
  }
  
  ThemeToggleManager._internal();
  
  @override
  void toggleTheme(WidgetRef ref) {
    // Toggle the theme mode in the custom theme provider
    ref.read(customThemeColorsProvider.notifier).toggleMode();
    
    // Sync with app theme
    ref.read(themeProvider.notifier).toggleDarkMode();
  }
  
  @override
  bool isDarkMode(WidgetRef ref) {
    return ref.watch(customThemeColorsProvider.select((state) => state.isDarkMode));
  }
  
  @override
  IconData getThemeIcon(bool isDarkMode) {
    return isDarkMode ? Icons.wb_sunny : Icons.nightlight_round;
  }
  
  @override
  String getThemeText(bool isDarkMode) {
    return isDarkMode ? 'Light Mode' : 'Dark Mode';
  }
  
  @override
  Color getIconColor(bool isDarkMode) {
    return isDarkMode ? Colors.amber : Colors.indigo;
  }
}
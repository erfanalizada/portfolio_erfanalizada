import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ThemeToggleInterface {
  /// Toggle between light and dark mode
  void toggleTheme(WidgetRef ref);
  
  /// Get the current theme mode
  bool isDarkMode(WidgetRef ref);
  
  /// Get icon for current theme mode
  IconData getThemeIcon(bool isDarkMode);
  
  /// Get text for current theme mode
  String getThemeText(bool isDarkMode);
  
  /// Get icon color for current theme mode
  Color getIconColor(bool isDarkMode);
}
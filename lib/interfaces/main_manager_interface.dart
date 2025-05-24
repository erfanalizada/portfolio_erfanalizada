import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class MainManagerInterface {
  /// Initialize the theme with custom colors
  void initializeTheme(WidgetRef ref);
  
  /// Get the default app color
  Color getDefaultColor();
  
  /// Get the app title
  String getAppTitle();
}
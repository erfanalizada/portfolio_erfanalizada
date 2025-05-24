import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme_changer_erfan/dynamic_theme_picker.dart';
import 'package:portfolio_erfanalizada/interfaces/main_manager_interface.dart';

class MainManager implements MainManagerInterface {
  // Singleton pattern
  static final MainManager _instance = MainManager._internal();
  
  factory MainManager() {
    return _instance;
  }
  
  MainManager._internal();
  
  @override
  void initializeTheme(WidgetRef ref) {
    // Define custom colors for light and dark modes
    final lightModeColors = {
      'main_background': const Color.fromARGB(255, 255, 255, 255),
      'secondary_background': const Color(0xFFF4F4F4),
      'primary': const Color(0xFFDAB11C),
      'text': const Color(0xFF001E29),
      'text_secondary': const Color(0xFF217D96),
      'shadow': const Color.fromARGB(138, 0, 0, 0),
    };

    final darkModeColors = {
      'main_background': const Color(0xFF02141D),
      'secondary_background': const Color(0xFF001E29),
      'primary': const Color(0xFFDAB11C),
      'text': const Color(0xFFFFFFFF),
      'text_secondary': const Color(0xFF55C3E1),
      'shadow': const Color.fromARGB(138, 0, 0, 0),
    };
    
    try {
      CustomThemeColorPalette.initialize(
        ref,
        lightModeColors: lightModeColors,
        darkModeColors: darkModeColors,
        isDarkMode: true,
        syncWithAppTheme: true,
      );
      
      // Explicitly set dark mode in the theme provider
      ref.read(themeProvider.notifier).toggleDarkMode();
    } catch (e) {
      debugPrint('Error initializing theme: $e');
    }
  }
  
  @override
  Color getDefaultColor() {
    return const Color(0xFF02141D);
  }
  
  @override
  String getAppTitle() {
    return 'Portfolio Erfan Alizada';
  }
}
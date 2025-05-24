import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme_changer_erfan/dynamic_theme_picker.dart';
import 'package:portfolio_erfanalizada/interfaces/main_manager_interface.dart';

// Define theme colors at the top level for reuse
final Map<String, Color> appLightModeColors = {
'main_background': const Color(0xFFF4F6F8),       // Light cool gray – clean and easy on the eyes
'secondary_background': const Color(0xFFE0E7EF),  // Pale blue-gray – for content blocks or cards
'primary': const Color(0xFF007BFF),               // Tech blue – vibrant but professional
'text': const Color.fromARGB(255, 0, 0, 0),                  // Charcoal – softer than black for better reading
'text_secondary': const Color(0xFF5F6B7A),        // Muted blue-gray – polished for secondary content
'shadow': const Color.fromARGB(40, 0, 0, 0),      // Light shadow – minimal depth for flat UI

};

final Map<String, Color> appDarkModeColors = {
  'main_background': const Color(0xFF02141D),
  'secondary_background': const Color(0xFF001E29),
  'primary': const Color(0xFFDAB11C),
  'text': const Color(0xFFFFFFFF),
  'text_secondary': const Color(0xFF55C3E1),
  'shadow': const Color.fromARGB(138, 0, 0, 0),
};

class MainManager implements MainManagerInterface {
  // Singleton pattern
  static final MainManager _instance = MainManager._internal();
  
  factory MainManager() {
    return _instance;
  }
  
  MainManager._internal();
  
  @override
  void initializeTheme(WidgetRef ref) {
    try {
      CustomThemeColorPalette.initialize(
        ref,
        lightModeColors: appLightModeColors,
        darkModeColors: appDarkModeColors,
        isDarkMode: true, // Default to dark mode
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
  
  @override
  Map<String, Color> getLightModeColors() {
    return appLightModeColors;
  }
  
  @override
  Map<String, Color> getDarkModeColors() {
    return appDarkModeColors;
  }
}


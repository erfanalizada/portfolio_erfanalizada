import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme_changer_erfan/dynamic_theme_picker.dart';
import 'package:portfolio_erfanalizada/screens/yellow_button_test_screen.dart';

void main() {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize theme once during initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeTheme();
      setState(() {
        _isInitialized = true;
      });
    });
  }
  
  void _initializeTheme() {
    // Define custom colors for light and dark modes
    final lightModeColors = {
      'main_background': Color.fromARGB(255, 255, 255, 255),
      'secondary_background': Color(0xFFF4F4F4),
      'primary': Color(0xFFDAB11C),
      'text': Color(0xFF001E29),
      'text_secondary': Color(0xFF217D96),
    };

    final darkModeColors = {
      'main_background': Color(0xFF02141D),
      'secondary_background': Color(0xFF001E29),
      'primary': Color(0xFFDAB11C),
      'text': Color(0xFFFFFFFF),
      'text_secondary': Color(0xFF55C3E1),
    };
    
    // Initialize custom theme colors
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
  Widget build(BuildContext context) {
    final darkBlueGreen = Color(0xFF02141D);
    
    // Show loading indicator until initialization is complete
    if (!_isInitialized) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: darkBlueGreen,
            ),
          ),
        ),
      );
    }
    
    return ThemeChanger(
      title: 'Portfolio Erfan Alizada',
      defaultColor: darkBlueGreen,
      child: const YellowButtonTestScreen(),
    );
  }
}
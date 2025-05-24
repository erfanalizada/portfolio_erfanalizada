import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme_changer_erfan/dynamic_theme_picker.dart';
import 'package:portfolio_erfanalizada/interfaces/main_manager_interface.dart';
import 'package:portfolio_erfanalizada/managers/main_manager.dart';
import 'package:portfolio_erfanalizada/screens/portfolio_screen.dart';

// Create a provider to track if initialization is complete
final initializationCompleteProvider = StateProvider<bool>((ref) => false);

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
  // Use the interface type instead of the concrete implementation
  final MainManagerInterface _mainManager = MainManager();

  @override
  void initState() {
    super.initState();
    // Initialize theme once during initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mainManager.initializeTheme(ref);
      // Mark initialization as complete
      ref.read(initializationCompleteProvider.notifier).state = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultColor = _mainManager.getDefaultColor();
    
    // Watch initialization state
    final isInitialized = ref.watch(initializationCompleteProvider);
    
    // Show loading indicator until initialization is complete
    if (!isInitialized) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: defaultColor,
            ),
          ),
        ),
      );
    }
    
    return ThemeChanger(
      title: _mainManager.getAppTitle(),
      defaultColor: defaultColor,
      child: const PortfolioScreen(),
    );
  }
}

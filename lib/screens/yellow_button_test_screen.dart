import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme_changer_erfan/dynamic_theme_picker.dart';
import 'package:portfolio_erfanalizada/interfaces/main_manager_interface.dart';
import 'package:portfolio_erfanalizada/interfaces/text_formatter_interface.dart';
import 'package:portfolio_erfanalizada/managers/main_manager.dart';
import 'package:portfolio_erfanalizada/managers/text_formatter_manager.dart';
import 'package:portfolio_erfanalizada/models/project_container_model.dart';
import 'package:portfolio_erfanalizada/widgets/project_container_widget.dart';
import 'package:portfolio_erfanalizada/widgets/yellow_button.dart';

class YellowButtonTestScreen extends ConsumerStatefulWidget {
  const YellowButtonTestScreen({super.key});

  @override
  ConsumerState<YellowButtonTestScreen> createState() =>
      _YellowButtonTestScreenState();
}

class _YellowButtonTestScreenState
    extends ConsumerState<YellowButtonTestScreen> {
  // Use the interface type instead of the concrete implementation
  final TextFormatterInterface _textFormatter = TextFormatterManager();
  final MainManagerInterface _mainManager = MainManager();

  @override
  Widget build(BuildContext context) {
    final colorPalette = CustomThemeColorPalette(ref);
    
    // Watch the dark mode state for UI updates
    final isDarkMode = ref.watch(
        customThemeColorsProvider.select((state) => state.isDarkMode));

    // Define the bullet points
    final String title = "flutter_theme_changer_erfan";
    final List<String> bulletPoints = [
      "This flutter package allows users to implement a widget that allows dynamic theme changes.",
      "Supports various light and dark themes.",
      "Easy to integrate with existing Flutter applications.",
    ];

    // Create a ProjectContainerModel using the factory constructor with default theme
    final projectModel = ProjectContainerModel.withDefaultTheme(
      ref: ref,
      icon: Icons.work,
      title: "Theme Changer",
      subtitle: "A Flutter package for changing app themes globally",
      containerWidth: 290,
      containerHeight: 400,
      imageUrls: ["assets/pictures/project_pic.png"],
      // Use the custom widget builder for formatted text
      customTextWidget: _textFormatter.buildTitleWithBulletPoints(
        title,
        bulletPoints,
        titleStyle: TextStyle(
          fontFamily: 'KohSantepheap',
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: colorPalette.getColor('primary'),
        ),
        bulletStyle: TextStyle(
          fontFamily: 'KohSantepheap',
          fontSize: 12.0,
          color: colorPalette.getColor('text'),
        ),
      ),
      yellowButton: YellowButton(
        text: "View Project",
        icon: Icons.arrow_forward_ios,
        onPressed: () {
          // Handle button press
        },
      ),
    );

    return Scaffold(
      backgroundColor: colorPalette.getColor('main_background'),
      appBar: AppBar(
        title: const Text('Yellow Button Test'),
        backgroundColor: colorPalette.getColor('secondary_background'),
        foregroundColor: colorPalette.getColor('text'),
        actions: [
          // Add the theme toggle in the app bar using the package's built-in widget
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DarkLightModeCustomToggle(
              lightModeColors: _mainManager.getLightModeColors(),
              darkModeColors: _mainManager.getDarkModeColors(),
              syncWithAppTheme: true,
              defaultDarkMode: true, // Default to dark mode
              key: const Key('themeToggle'),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProjectContainerWidget(model: projectModel),
            
            // Add some spacing
            const SizedBox(height: 20),
            
            // Display current theme mode
            Text(
              'Current Theme: ${isDarkMode ? "Dark Mode" : "Light Mode"}',
              style: TextStyle(
                color: colorPalette.getColor('text'),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Add another theme toggle in the body for demonstration
            DarkLightModeCustomToggle(
              lightModeColors: _mainManager.getLightModeColors(),
              darkModeColors: _mainManager.getDarkModeColors(),
              syncWithAppTheme: true,
              defaultDarkMode: true,
              key: const Key('bodyThemeToggle'),
            ),
          ],
        ),
      ),
    );
  }
}

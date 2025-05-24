import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme_changer_erfan/dynamic_theme_picker.dart';
import 'package:portfolio_erfanalizada/interfaces/text_formatter_interface.dart';
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

  @override
  Widget build(BuildContext context) {
    final colorPalette = CustomThemeColorPalette(ref);

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
      appBar: AppBar(title: const Text('Yellow Button Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ProjectContainerWidget(model: projectModel)],
        ),
      ),
    );
  }
}

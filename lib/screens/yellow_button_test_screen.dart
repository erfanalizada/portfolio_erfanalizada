import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme_changer_erfan/dynamic_theme_picker.dart';
import 'package:portfolio_erfanalizada/utils/text_formatter_manager.dart';
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
  final TextFormatterManager _textFormatter = TextFormatterManager();
  
  @override
  Widget build(BuildContext context) {
    final colorPalette = CustomThemeColorPalette(ref);
    
    // Define the bullet points
    final String title = "flutter_theme_changer_erfan";
    final List<String> bulletPoints = [
      "This flutter package allows users to implement a widget that allows dynamic theme changes.",
      "Supports various light and dark themes.",
      "Easy to integrate with existing Flutter applications."
    ];
    
    return Scaffold(
      backgroundColor: colorPalette.getColor('main_background'),
      appBar: AppBar(title: const Text('Yellow Button Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProjectContainerWidget(
              icon: Icons.work,
              title: "Theme Changer",
              subtitle: "A Flutter package for changing app themes globally",
              containerWidth: 290,
              containerHeight: 400,
              imageUrls: [
                "assets/pictures/project_pic.png",
              ],
              // Use the custom widget builder for formatted text
              customTextWidget: _textFormatter.buildTitleWithBulletPoints(
                title,
                bulletPoints,
                titleStyle: TextStyle(
                  fontFamily: 'KohSantepheap',
                  fontSize: 12.0,
                  fontWeight: FontWeight.normal,
                  color: colorPalette.getColor('text_secondary'),
                ),
                bulletStyle: TextStyle(
                  fontFamily: 'KohSantepheap',
                  fontSize: 12.0,
                  color: colorPalette.getColor('text'),
                ),
              ),
              minWidth: 300,
              minHeight: 200,
              containerColor: colorPalette.getColor('secondary_background'),
              titleColor: colorPalette.getColor('primary'),
              subtitleColor: colorPalette.getColor('text'),
              textColor: colorPalette.getColor('text'),
              imageHeight: 150,
              imageWidth: 270,
              imageRadius: 25,
              yellowButton: YellowButton(
                text: "View Project",
                onPressed: () {
                  // Handle button press
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

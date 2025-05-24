import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme_changer_erfan/dynamic_theme_picker.dart';
import 'package:portfolio_erfanalizada/interfaces/model_builder_interface.dart';
import 'package:portfolio_erfanalizada/managers/text_formatter_manager.dart';
import 'package:portfolio_erfanalizada/models/project_container_model.dart';
import 'package:portfolio_erfanalizada/widgets/yellow_button.dart';

// Provider for ModelBuilderManager
final modelBuilderProvider = Provider<ModelBuilderInterface>((ref) {
  return ModelBuilderManager();
});

class ModelBuilderManager implements ModelBuilderInterface {
  // Singleton pattern
  static final ModelBuilderManager _instance = ModelBuilderManager._internal();
  
  factory ModelBuilderManager() {
    return _instance;
  }
  
  ModelBuilderManager._internal();
  
  @override
  ProjectContainerModel buildProfileModel(WidgetRef ref) {
    final colorPalette = CustomThemeColorPalette(ref);
    
    return ProjectContainerModel(
      // Content properties
      title: 'Erfan Alizada',
      subtitle: 'Software Engineer',
      imageUrls: ['assets/pictures/profile_pic.png'],
      text: 'Specializing in Mobile & Web App Development and APIs',
      
      // Sizing properties
      containerWidth: 750,
      containerHeight: 450,
      minWidth: 300.0,
      minHeight: 200.0,
      
      // Color properties
      containerColor: colorPalette.getColor('secondary_background'),
      titleColor: colorPalette.getColor('primary'),
      subtitleColor: colorPalette.getColor('text'),
      textColor: colorPalette.getColor('text'),
      shadowColor: colorPalette.getColor('shadow'),
      
      // Border properties
      containerBorderColor: colorPalette.getColor('primary'),
      containerBorderWidth: 1.0,
      imageBorderColor: colorPalette.getColor('primary'),
      imageBorderWidth: 1.0,
      
      // Hover effect properties
      hoverGlowColor: colorPalette.getColor('primary'),
      hoverGlowRadius: 12.0,
      enableHoverEffect: true,
    );
  }
  
  @override
  ProjectContainerModel buildProjectModel(WidgetRef ref) {
    final colorPalette = CustomThemeColorPalette(ref);
    final textFormatter = TextFormatterManager();
    
    // Define the bullet points
    final String title = "flutter_theme_changer_erfan";
    final List<String> bulletPoints = [
      "This flutter package allows users to implement a widget that allows dynamic theme changes.",
      "Supports various light and dark themes.",
      "Easy to integrate with existing Flutter applications.",
    ];
    
    return ProjectContainerModel(
      // Content properties
      icon: Icons.work,
      title: "Theme Changer",
      subtitle: "A Flutter package for changing app themes globally",
      imageUrls: ["assets/pictures/project_pic.png"],
      customTextWidget: textFormatter.buildTitleWithBulletPoints(
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
      
      // Sizing properties
      containerWidth: 290,
      containerHeight: 400,
      minWidth: 250.0,
      minHeight: 350.0,
      
      // Color properties
      containerColor: colorPalette.getColor('secondary_background'),
      titleColor: colorPalette.getColor('primary'),
      subtitleColor: colorPalette.getColor('text'),
      textColor: colorPalette.getColor('text'),
      shadowColor: colorPalette.getColor('shadow'),
      
      // Border properties
      containerBorderColor: colorPalette.getColor('primary'),
      containerBorderWidth: 1.0,
      imageBorderColor: colorPalette.getColor('primary'),
      imageBorderWidth: 1.0,
      
      // Hover effect properties
      hoverGlowColor: colorPalette.getColor('primary'),
      hoverGlowRadius: 12.0,
      enableHoverEffect: true,
    );
  }
}
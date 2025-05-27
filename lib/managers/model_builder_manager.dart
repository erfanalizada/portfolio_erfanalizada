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
      
      // Sizing properties - standardized for consistency with 15% width reduction + 30px
      containerWidth: 370, // Increased from 340 by 30px
      containerHeight: 450,
      minWidth: 285.0, // Increased from 255 by 30px
      minHeight: 400.0,
      
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
  ProjectContainerModel buildAiForSocietyProjectModel(WidgetRef ref) {
    final colorPalette = CustomThemeColorPalette(ref);
    final textFormatter = TextFormatterManager();
    
    // Define the bullet points for the AI for Society project
    final String title = "AI for Society";
    final List<String> bulletPoints = [
      "A project focused on using AI to solve social challenges.",
      "Implements machine learning models for community benefit.",
      "Open-source collaboration with multiple contributors.",
    ];
    
    return ProjectContainerModel(
      // Content properties
      icon: Icons.psychology,
      title: "AI for Society",
      subtitle: "Using technology for social good",
      // Use an existing image as a temporary replacement
      imageUrls: ["assets/pictures/ai_for_society.png"], // Using an image we know exists
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
      
      // Sizing properties - standardized with 15% width reduction + 30px
      containerWidth: 370, // Increased from 340 by 30px
      containerHeight: 450,
      minWidth: 285.0, // Increased from 255 by 30px
      minHeight: 400.0,
      
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
  ProjectContainerModel buildCyberSecuritySemesterProjectModel(WidgetRef ref) {
    final colorPalette = CustomThemeColorPalette(ref);
    final textFormatter = TextFormatterManager();

    final String title = "Cyber Security Semester";
    final List<String> bulletPoints = [
      "Learned about network security, cryptography, and ethical hacking.",
      "Hands-on labs with penetration testing tools (e.g., Kali Linux, Wireshark).",
      "Completed a group project on securing web applications.",
      "Studied real-world cyber attacks and defense strategies."
    ];

    return ProjectContainerModel(
      icon: Icons.security,
      title: "Cyber Security Semester",
      subtitle: "A comprehensive journey into cybersecurity fundamentals",
      imageUrls: ["assets/pictures/project_pic.png"], // Replace with a relevant image if available
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
        text: "View Details",
        icon: Icons.arrow_forward_ios,
        onPressed: () {
          // Handle button press for cybersecurity semester project
        },
      ),
      containerWidth: 370,
      containerHeight: 450,
      minWidth: 285.0,
      minHeight: 400.0,
      containerColor: colorPalette.getColor('secondary_background'),
      titleColor: colorPalette.getColor('primary'),
      subtitleColor: colorPalette.getColor('text'),
      textColor: colorPalette.getColor('text'),
      shadowColor: colorPalette.getColor('shadow'),
      containerBorderColor: colorPalette.getColor('primary'),
      containerBorderWidth: 1.0,
      imageBorderColor: colorPalette.getColor('primary'),
      imageBorderWidth: 1.0,
      hoverGlowColor: colorPalette.getColor('primary'),
      hoverGlowRadius: 12.0,
      enableHoverEffect: true,
    );
  }

  @override
  ProjectContainerModel buildYoutubeMuxerProjectModel(WidgetRef ref) {
    final colorPalette = CustomThemeColorPalette(ref);
    final textFormatter = TextFormatterManager();

    final String title = "youtube_muxer";
    final List<String> bulletPoints = [
      "Open-source Flutter package for merging and muxing YouTube video/audio streams.",
      "Handles adaptive streaming and supports various formats.",
      "Published on pub.dev and available for community contributions.",
      "Easy integration for Flutter video apps.",
    ];

    return ProjectContainerModel(
      icon: Icons.video_library,
      title: "YouTube Muxer",
      subtitle: "Open-source Flutter package for YouTube stream muxing",
      imageUrls: ["assets/pictures/youtube_muxer.png"], // Use your asset or a placeholder
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
        text: "View on pub.dev",
        icon: Icons.open_in_new,
        onPressed: () {
          // Add your pub.dev or GitHub link action here
        },
      ),
      containerWidth: 370,
      containerHeight: 450,
      minWidth: 285.0,
      minHeight: 400.0,
      containerColor: colorPalette.getColor('secondary_background'),
      titleColor: colorPalette.getColor('primary'),
      subtitleColor: colorPalette.getColor('text'),
      textColor: colorPalette.getColor('text'),
      shadowColor: colorPalette.getColor('shadow'),
      containerBorderColor: colorPalette.getColor('primary'),
      containerBorderWidth: 1.0,
      imageBorderColor: colorPalette.getColor('primary'),
      imageBorderWidth: 1.0,
      hoverGlowColor: colorPalette.getColor('primary'),
      hoverGlowRadius: 12.0,
      enableHoverEffect: true,
    );
  }

  @override
  ProjectContainerModel buildTimePickerProjectModel(WidgetRef ref) {
    final colorPalette = CustomThemeColorPalette(ref);
    final textFormatter = TextFormatterManager();

    final String title = "erfan_time_picker";
    final List<String> bulletPoints = [
      "A customizable and easy-to-use time picker widget for Flutter.",
      "Supports 12/24 hour formats, custom themes, and validation.",
      "Published on pub.dev for the Flutter community.",
      "Seamless integration with forms and dialogs.",
    ];

    return ProjectContainerModel(
      icon: Icons.access_time,
      title: "Erfan Time Picker",
      subtitle: "A flexible time picker Flutter package",
      imageUrls: ["assets/pictures/flutter_pic.png"], // Use a relevant image asset
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
        text: "View on pub.dev",
        icon: Icons.open_in_new,
        onPressed: () {
          // Add your pub.dev or GitHub link action here
        },
      ),
      containerWidth: 370,
      containerHeight: 450,
      minWidth: 285.0,
      minHeight: 400.0,
      containerColor: colorPalette.getColor('secondary_background'),
      titleColor: colorPalette.getColor('primary'),
      subtitleColor: colorPalette.getColor('text'),
      textColor: colorPalette.getColor('text'),
      shadowColor: colorPalette.getColor('shadow'),
      containerBorderColor: colorPalette.getColor('primary'),
      containerBorderWidth: 1.0,
      imageBorderColor: colorPalette.getColor('primary'),
      imageBorderWidth: 1.0,
      hoverGlowColor: colorPalette.getColor('primary'),
      hoverGlowRadius: 12.0,
      enableHoverEffect: true,
    );
  }
}






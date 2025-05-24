import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme_changer_erfan/dynamic_theme_picker.dart';
import 'package:portfolio_erfanalizada/widgets/yellow_button.dart';


/// Model class that encapsulates all properties for the ProjectContainerWidget
class ProjectContainerModel {
  // Content properties
  final IconData? icon;
  final String? title;
  final String? subtitle;
  final List<String>? imageUrls;
  final String? text;
  final Widget? customTextWidget;
  final String? textId;
  final YellowButton? yellowButton;
  
  // Sizing properties
  final double? containerWidth;
  final double? containerHeight;
  final double minWidth;
  final double minHeight;
  final double? imageWidth;
  final double? imageHeight;
  final double? imageRadius;
  final double? imageSize;
  
  // Color properties
  final Color containerColor;
  final Color titleColor;
  final Color subtitleColor;
  final Color textColor;
  final Color shadowColor;
  
  // Border properties
  final Color? containerBorderColor;
  final double containerBorderWidth;
  final Color? imageBorderColor;
  final double imageBorderWidth;
  
  // Hover effect properties
  final Color? hoverGlowColor;
  final double hoverGlowRadius;
  final bool enableHoverEffect;

  /// Custom constructor - allows full customization of all properties
  /// Use this when you need to override the default theme values
  const ProjectContainerModel({
    this.icon,
    this.title,
    this.subtitle,
    this.containerWidth,
    this.containerHeight,
    this.imageUrls,
    this.imageSize,
    this.imageWidth,
    this.imageHeight,
    this.imageRadius,
    this.text,
    this.customTextWidget,
    this.textId,
    this.yellowButton,
    this.containerColor = Colors.white,
    this.titleColor = Colors.black,
    this.subtitleColor = Colors.black87,
    this.textColor = Colors.black54,
    this.shadowColor = Colors.black,
    this.minWidth = 300.0,
    this.minHeight = 200.0,
    this.containerBorderColor,
    this.containerBorderWidth = 1.0,
    this.imageBorderColor,
    this.imageBorderWidth = 1.0,
    this.hoverGlowColor,
    this.hoverGlowRadius = 12.0,
    this.enableHoverEffect = true,
  });
  
  /// Creates a copy of this model with the given fields replaced with new values
  ProjectContainerModel copyWith({
    IconData? icon,
    String? title,
    String? subtitle,
    List<String>? imageUrls,
    String? text,
    Widget? customTextWidget,
    String? textId,
    YellowButton? yellowButton,
    double? containerWidth,
    double? containerHeight,
    double? minWidth,
    double? minHeight,
    double? imageWidth,
    double? imageHeight,
    double? imageRadius,
    double? imageSize,
    Color? containerColor,
    Color? titleColor,
    Color? subtitleColor,
    Color? textColor,
    Color? shadowColor,
    Color? containerBorderColor,
    double? containerBorderWidth,
    Color? imageBorderColor,
    double? imageBorderWidth,
    Color? hoverGlowColor,
    double? hoverGlowRadius,
    bool? enableHoverEffect,
  }) {
    return ProjectContainerModel(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imageUrls: imageUrls ?? this.imageUrls,
      text: text ?? this.text,
      customTextWidget: customTextWidget ?? this.customTextWidget,
      textId: textId ?? this.textId,
      yellowButton: yellowButton ?? this.yellowButton,
      containerWidth: containerWidth ?? this.containerWidth,
      containerHeight: containerHeight ?? this.containerHeight,
      minWidth: minWidth ?? this.minWidth,
      minHeight: minHeight ?? this.minHeight,
      imageWidth: imageWidth ?? this.imageWidth,
      imageHeight: imageHeight ?? this.imageHeight,
      imageRadius: imageRadius ?? this.imageRadius,
      imageSize: imageSize ?? this.imageSize,
      containerColor: containerColor ?? this.containerColor,
      titleColor: titleColor ?? this.titleColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      textColor: textColor ?? this.textColor,
      shadowColor: shadowColor ?? this.shadowColor,
      containerBorderColor: containerBorderColor ?? this.containerBorderColor,
      containerBorderWidth: containerBorderWidth ?? this.containerBorderWidth,
      imageBorderColor: imageBorderColor ?? this.imageBorderColor,
      imageBorderWidth: imageBorderWidth ?? this.imageBorderWidth,
      hoverGlowColor: hoverGlowColor ?? this.hoverGlowColor,
      hoverGlowRadius: hoverGlowRadius ?? this.hoverGlowRadius,
      enableHoverEffect: enableHoverEffect ?? this.enableHoverEffect,
    );
  }

  /// Theme-aware constructor - uses the app's color palette for styling
  /// Use this for consistent styling across the app
  factory ProjectContainerModel.withDefaultTheme({
    required WidgetRef ref,
    IconData? icon,
    String? title,
    String? subtitle,
    List<String>? imageUrls,
    String? text,
    Widget? customTextWidget,
    String? textId,
    YellowButton? yellowButton,
    double? containerWidth,
    double? containerHeight,
    double minWidth = 300.0,
    double minHeight = 200.0,
    double? imageWidth = 270.0,
    double? imageHeight = 150.0,
    double? imageRadius = 10.0,
    double? imageSize,
    double containerBorderWidth = 0.5,
    double imageBorderWidth = 0.5,
    double hoverGlowRadius = 15.0,
    bool enableHoverEffect = true,
  }) {
    final colorPalette = CustomThemeColorPalette(ref);
    
    return ProjectContainerModel(
      // Content properties
      icon: icon,
      title: title,
      subtitle: subtitle,
      imageUrls: imageUrls,
      text: text,
      customTextWidget: customTextWidget,
      textId: textId,
      yellowButton: yellowButton,
      
      // Sizing properties
      containerWidth: containerWidth,
      containerHeight: containerHeight,
      minWidth: minWidth,
      minHeight: minHeight,
      imageWidth: imageWidth,
      imageHeight: imageHeight,
      imageRadius: imageRadius,
      imageSize: imageSize,
      
      // Color properties - all using colorPalette
      containerColor: colorPalette.getColor('secondary_background'),
      titleColor: colorPalette.getColor('primary'),
      subtitleColor: colorPalette.getColor('text'),
      textColor: colorPalette.getColor('text'),
      shadowColor: colorPalette.getColor('shadow'),
      
      // Border properties - all using colorPalette
      containerBorderColor: colorPalette.getColor('text'),
      containerBorderWidth: containerBorderWidth,
      imageBorderColor: colorPalette.getColor('text'),
      imageBorderWidth: imageBorderWidth,
      
      // Hover effect properties - all using colorPalette
      hoverGlowColor: colorPalette.getColor('text_secondary'),
      hoverGlowRadius: hoverGlowRadius,
      enableHoverEffect: enableHoverEffect,
    );
  }
}


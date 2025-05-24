import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme_changer_erfan/dynamic_theme_picker.dart';

class YellowButton extends ConsumerWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Image? iconImage;
  final double? width;  // Optional width parameter
  final double? height; // Optional height parameter

  const YellowButton({
    super.key, 
    required this.text, 
    required this.onPressed, 
    this.icon,
    this.iconImage,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get screen size
    final screenSize = MediaQuery.of(context).size;

    // Get colors
    final colorPalette = CustomThemeColorPalette(ref);
    
    // Calculate responsive width and height if not explicitly provided
    final buttonWidth = width ?? screenSize.width * 0.07;
    final buttonHeight = height ?? screenSize.height * 0.05;
    
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPalette.getColor('primary'),
          padding: EdgeInsets.symmetric(
            horizontal: 2.0, // Minimal horizontal padding
            vertical: 4.0,
          ),
        ),
        child: Stack(
          children: [
            // Centered text
            Center(
              child: Text(
                text,
                style: TextStyle(
                  color: colorPalette.getColor('text'),
                  fontSize: buttonWidth * 0.12, // Larger font
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            
            // Right-aligned icon
            if(icon != null || iconImage != null)
              Positioned(
                right: 2.0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: icon != null 
                    ? Icon(icon,size: buttonWidth * 0.17)
                    : SizedBox(
                        width: 16.0,
                        height: 16.0,
                        child: iconImage!,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

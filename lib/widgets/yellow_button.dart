import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme_changer_erfan/dynamic_theme_picker.dart';

class YellowButton extends ConsumerWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Image? iconImage;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? iconSize;

  const YellowButton({
    super.key, 
    required this.text, 
    required this.onPressed, 
    this.icon,
    this.iconImage,
    this.width,
    this.height,
    this.fontSize,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPalette = CustomThemeColorPalette(ref);
    final buttonWidth = width ?? 150.0;
    final buttonHeight = height ?? 35.0;
    
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPalette.getColor('primary'),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          elevation: 0,
        ),
        child: Stack(
          children: [
            // Centered text
            Center(
              child: _buildText(colorPalette, buttonWidth),
            ),
            
            // Right-aligned icon with original padding
            Positioned(
              right: 5.0,
              top: 0,
              bottom: 0,
              child: Center(
                child: _buildIcon(
                  colorPalette, 
                  buttonWidth, 
                  icon ?? Icons.arrow_forward
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(CustomThemeColorPalette colorPalette, double buttonWidth) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'KohSantepheap',
        fontWeight: FontWeight.w700,  // Use 700 weight for Bold font
        color: colorPalette.getColor('main_background'),
        fontSize: fontSize ?? 14.0,
        package: null, // Ensure we're not looking in a package
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _buildIcon(CustomThemeColorPalette colorPalette, double buttonWidth, IconData? iconData) {
    final actualIconSize = iconSize ?? 18.0;
    
    if (iconImage != null) {
      return SizedBox(
        width: actualIconSize,
        height: actualIconSize,
        child: iconImage!,
      );
    }
    
    return Icon(
      iconData ?? Icons.arrow_forward,
      size: actualIconSize,
      color: colorPalette.getColor('main_background'),
    );
  }
}

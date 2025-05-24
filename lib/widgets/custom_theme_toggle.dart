import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_erfanalizada/interfaces/theme_toggle_interface.dart';
import 'package:portfolio_erfanalizada/managers/theme_toggle_manager.dart';

class CustomThemeToggle extends ConsumerWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  
  const CustomThemeToggle({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use the interface type instead of the concrete implementation
    final ThemeToggleInterface themeToggle = ThemeToggleManager();
    
    // Get current theme mode
    final isDarkMode = themeToggle.isDarkMode(ref);

    return GestureDetector(
      onTap: () => themeToggle.toggleTheme(ref),
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              themeToggle.getThemeIcon(isDarkMode),
              color: themeToggle.getIconColor(isDarkMode),
            ),
            const SizedBox(width: 8),
            Text(
              themeToggle.getThemeText(isDarkMode),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
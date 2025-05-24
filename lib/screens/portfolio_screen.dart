import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme_changer_erfan/dynamic_theme_picker.dart';
import 'package:portfolio_erfanalizada/managers/profile_manager.dart';
import 'package:portfolio_erfanalizada/widgets/profile_container_widget.dart';
import 'package:portfolio_erfanalizada/widgets/project_container_widget.dart';
import 'package:portfolio_erfanalizada/widgets/custom_theme_toggle.dart';

class PortfolioScreen extends ConsumerWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the theme state to rebuild when it changes
    final isDarkMode = ref.watch(customThemeColorsProvider.select((state) => state.isDarkMode));
    
    // Get models from profile manager - recreate them on each build to get updated colors
    final profileManager = ref.read(profileManagerProvider);
    final profileModel = profileManager.getProfileContainerModel(ref);
    final projectModel = profileManager.getThemeChangerInfoModel(ref);
    
    // Get the correct background color from the theme palette
    final colorPalette = CustomThemeColorPalette(ref);
    final backgroundColor = colorPalette.getColor('main_background');
    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Portfolio'),
        backgroundColor: colorPalette.getColor('secondary_background'),
        actions: [
          // Use the custom theme toggle widget
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CustomThemeToggle(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // For wider screens, show containers side by side
            if (constraints.maxWidth > 800) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile container with constraints
                  Expanded(
                    flex: 1,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: ProfileContainerWidget(model: profileModel),
                    ),
                  ),
                  
                  const SizedBox(width: 24.0),
                  
                  // Project container with constraints
                  Expanded(
                    flex: 1,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: ProjectContainerWidget(model: projectModel),
                    ),
                  ),
                ],
              );
            } else {
              // For narrower screens, stack them vertically with constraints
              return Column(
                children: [
                  // Profile container
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: ProfileContainerWidget(model: profileModel),
                  ),
                  
                  const SizedBox(height: 24.0),
                  
                  // Project container
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: ProjectContainerWidget(model: projectModel),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}






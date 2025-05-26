import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme_changer_erfan/dynamic_theme_picker.dart';
import 'package:portfolio_erfanalizada/managers/profile_manager.dart';
import 'package:portfolio_erfanalizada/widgets/layout_blueprint.dart';
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
    final aiForSocietyModel = profileManager.getAiForSocietyProjectModel(ref);
    
    // Create another profile container model (you might want to add a method in your ProfileManager)
    // For example: final anotherProfileModel = profileManager.getSecondaryProfileModel(ref);
    
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
        child: LayoutBlueprint(
          mainContainer: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: profileModel.containerWidth ?? 750,
            ),
            child: ProfileContainerWidget(model: profileModel),
          ),
          leftContainers: [
            // Additional profile container that goes below the main profile
            ProfileContainerWidget(model: profileModel), 
            ProfileContainerWidget(model: profileModel),// You'd use secondaryProfileModel here
          ],
          rightContainers: [
            ProjectContainerWidget(model: projectModel),
            ProjectContainerWidget(model: aiForSocietyModel),
          ],
        ),
      ),
    );
  }
}















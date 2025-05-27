import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_theme_changer_erfan/dynamic_theme_picker.dart';
import 'package:portfolio_erfanalizada/managers/profile_manager.dart';
import 'package:portfolio_erfanalizada/widgets/custom_theme_toggle.dart';
import 'package:portfolio_erfanalizada/widgets/layout_blueprint.dart';
import 'package:portfolio_erfanalizada/widgets/profile_container_widget.dart';
import 'package:portfolio_erfanalizada/widgets/project_container_widget.dart';
import 'package:portfolio_erfanalizada/widgets/tall_project_container.dart';

class PortfolioScreen extends ConsumerWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize models using ProfileManager
    final profileManager = ref.read(profileManagerProvider);
    
    // Watch the theme state to ensure the screen rebuilds when theme changes
    final isDarkMode = ref.watch(customThemeColorsProvider.select((state) => state.isDarkMode));
    
    // Get the color palette to use for theming
    final colorPalette = CustomThemeColorPalette(ref);
    
    final profileModel = profileManager.getProfileContainerModel(ref);
    final projectModel = profileManager.getThemeChangerInfoModel(ref);
    final aiForSocietyModel = profileManager.getAiForSocietyProjectModel(ref);
    final youtubeMuxerModel = profileManager.getYoutubeMuxerProjectModel(ref);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPalette.getColor('secondary_background'),
        foregroundColor: colorPalette.getColor('text'),
        title: const Text('Erfan Alizada'),
        actions: [
          // Add the theme toggle widget to the app bar
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CustomThemeToggle(
              height: 40,
              borderRadius: 20,
            ),
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
            // Additional profile containers that go below the main profile
            ProfileContainerWidget(model: profileModel), 
            ProfileContainerWidget(model: profileModel),
             Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ProjectContainerWidget(model: profileModel),
                ),
                SizedBox(width: 24), // Match the spacing in LayoutBlueprint
                Expanded(
                  child: ProjectContainerWidget(model: projectModel),
                ),
                SizedBox(width: 24), // Match the spacing in LayoutBlueprint
                Expanded(
                  child: ProjectContainerWidget(model: aiForSocietyModel),
                ),
              ],
            ),
            
            // Another row with different containers
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ProjectContainerWidget(model: aiForSocietyModel),
                ),
                SizedBox(width: 24),
                Expanded(
                  child: ProjectContainerWidget(model: profileModel),
                ),
              ],
            ),
          ],
          rightContainers: [
            ProjectContainerWidget(model: projectModel),
            ProjectContainerWidget(model: aiForSocietyModel),
            ProjectContainerWidget(model: aiForSocietyModel),
            ProjectContainerWidget(model: aiForSocietyModel),
          ],
          // Center containers that span both columns
          centerContainers: [
            TallProjectContainer(model: youtubeMuxerModel),
            // You can add more center containers here if needed
            
            // After the center containers, we can add a Row with additional profile and project containers
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ProfileContainerWidget(model: profileModel),
                ),
                SizedBox(width: 24), // Match the spacing in LayoutBlueprint
                Expanded(
                  child: ProjectContainerWidget(model: projectModel),
                ),
              ],
            ),
            
            // Another row with different containers
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ProjectContainerWidget(model: aiForSocietyModel),
                ),
                SizedBox(width: 24),
                Expanded(
                  child: ProfileContainerWidget(model: profileModel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}











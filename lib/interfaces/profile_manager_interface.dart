import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_erfanalizada/models/project_container_model.dart';

abstract class ProfileManagerInterface {
  /// Get the profile container model with default settings
  ProjectContainerModel getProfileContainerModel(WidgetRef ref);
  
  /// Get the theme changer info model
  ProjectContainerModel getThemeChangerInfoModel(WidgetRef ref);
}


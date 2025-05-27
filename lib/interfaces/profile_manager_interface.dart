import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_erfanalizada/models/project_container_model.dart';

abstract class ProfileManagerInterface {
  /// Get the profile container model with default settings
  ProjectContainerModel getProfileContainerModel(WidgetRef ref);
  
  /// Get the theme changer info model
  ProjectContainerModel getThemeChangerInfoModel(WidgetRef ref);
  
  /// Get the AI for Society project info model
  ProjectContainerModel getAiForSocietyProjectModel(WidgetRef ref);

  /// Get the Cyber Security Semester project info model
  ProjectContainerModel getCyberSecuritySemesterProjectModel(WidgetRef ref);

  /// Get the YouTube Muxer Flutter package project info model
  ProjectContainerModel getYoutubeMuxerProjectModel(WidgetRef ref);

  /// Get the Time Picker Flutter package project info model
  ProjectContainerModel getTimePickerProjectModel(WidgetRef ref);
}



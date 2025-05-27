import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_erfanalizada/models/project_container_model.dart';

abstract class ModelBuilderInterface {
  /// Build a model for the profile container
  ProjectContainerModel buildProfileModel(WidgetRef ref);
  
  /// Build a model for a project container
  ProjectContainerModel buildProjectModel(WidgetRef ref);
  
  /// Build a model for the AI for Society project container
  ProjectContainerModel buildAiForSocietyProjectModel(WidgetRef ref);

  /// Build a model for the Cyber Security Semester project container
  ProjectContainerModel buildCyberSecuritySemesterProjectModel(WidgetRef ref);
}

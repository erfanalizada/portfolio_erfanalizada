import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_erfanalizada/interfaces/profile_manager_interface.dart';
import 'package:portfolio_erfanalizada/managers/model_builder_manager.dart';
import 'package:portfolio_erfanalizada/models/project_container_model.dart';

// Provider for ProfileManager
final profileManagerProvider = Provider<ProfileManagerInterface>((ref) {
  return ProfileManager();
});

class ProfileManager implements ProfileManagerInterface {
  // Singleton pattern
  static final ProfileManager _instance = ProfileManager._internal();
  
  factory ProfileManager() {
    return _instance;
  }
  
  ProfileManager._internal();
  
  @override
  ProjectContainerModel getProfileContainerModel(WidgetRef ref) {
    final modelBuilder = ref.read(modelBuilderProvider);
    return modelBuilder.buildProfileModel(ref);
  }
  
  @override
  ProjectContainerModel getThemeChangerInfoModel(WidgetRef ref) {
    final modelBuilder = ref.read(modelBuilderProvider);
    return modelBuilder.buildProjectModel(ref);
  }
  
  @override
  ProjectContainerModel getAiForSocietyProjectModel(WidgetRef ref) {
    final modelBuilder = ref.read(modelBuilderProvider);
    return modelBuilder.buildAiForSocietyProjectModel(ref);
  }
}







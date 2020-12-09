abstract class StartupService {
  Future<void> writeOnboardingViewed();

  Future<bool> readOnboardingViewed();
}

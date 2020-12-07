import 'package:get_storage/get_storage.dart';

import 'startup_service.dart';

class GetStorageService extends StartupService {
  final box = GetStorage();

  @override
  Future<void> writeOnboardingViewed() async {
    await box.write('onboardingViewed', true);
  }

  @override
  Future<bool> readOnboardingViewed() async {
    return (await box.read('onboardingViewed')) ?? false;
  }
}

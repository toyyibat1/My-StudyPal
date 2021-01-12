import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../models/app_user.dart';
import '../services/auth_service/auth_service.dart';
import '../services/startup_service/startup_service.dart';
import '../views/screens/create_account_screen.dart';
import '../views/screens/home_screen.dart';
import '../views/screens/onboarding_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    decideNavigation();
    super.onInit();
  }

  void decideNavigation() async {
    await Future.delayed(Duration(seconds: 3));

    bool onboardingViewed =
        await Get.find<StartupService>().readOnboardingViewed();
    if (onboardingViewed) {
      AppUser user = await Get.find<AuthService>().getAuthenticatedUser();
      if (user == null) {
        Get.off(CreateAccountScreen());
      } else {
        Get.off(HomeScreen(user: user));
      }
    } else {
      Get.off(OnboardingScreen());
    }
  }
}

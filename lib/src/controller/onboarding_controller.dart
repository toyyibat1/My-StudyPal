import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/views/screens/create_account_screen.dart';

import '../services/startup_service/startup_service.dart';

class OnboardingController extends GetxController {
  int _currentIndex = 0;
  final int _numPages = 4;
  PageController _pageController;

  int get currentIndex => _currentIndex;
  int get numPages => _numPages;
  PageController get pageController => _pageController;

  @override
  void onInit() {
    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }

  void onChangedFunction(int index) {
    _currentIndex = index;
    update();
  }

  void signUp() async {
    await Get.find<StartupService>().writeOnboardingViewed();
    Get.off(CreateAccountScreen());
  }
}

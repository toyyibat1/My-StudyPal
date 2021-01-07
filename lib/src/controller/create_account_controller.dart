import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

import '../views/screens/signin_screen.dart';
import '../views/screens/signup_screen.dart';

class CreateAccountController extends GetxController {
  TapGestureRecognizer _signIn;
  TapGestureRecognizer get signIn => _signIn;

  @override
  void onInit() {
    _signIn = TapGestureRecognizer()
      ..onTap = () {
        Get.off(SigninScreen());
      };
    super.onInit();
  }

  @override
  void onClose() {
    _signIn.dispose();
    super.onClose();
  }

  void navigateToSignup() => Get.to(SignupScreen());
}

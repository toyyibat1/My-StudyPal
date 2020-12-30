import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/views/screens/create_account_screen.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/app_user.dart';
import '../models/signin_params.dart';
import '../services/auth_service/auth_service.dart';
import '../services/data_connection_service/data_connection_service.dart';
import '../views/screens/home_screen.dart';

class SigninController extends Notifier with ValidationMixin {
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
//
//  bool obscureText = true;
//  Icon icon = Icon(Icons.remove_red_eye);

  final _formKey = GlobalKey<FormState>();
  TapGestureRecognizer _createAccount;

  TextEditingController get emailAddressController => _emailAddressController;
  TextEditingController get passwordController => _passwordController;

  TapGestureRecognizer get createAccount => _createAccount;
  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onInit() {
    _createAccount = TapGestureRecognizer()
      ..onTap = () {
        Get.off(CreateAccountScreen());
      };
    super.onInit();
  }

  // Toggles the password show status
//  void toggle() {
//    obscureText = !obscureText;
//    if (!obscureText) {
//      icon = Icon(Icons.panorama_fish_eye_outlined);
//    } else {
//      icon = Icon(Icons.remove_red_eye);
//    }
//  }

  void signinUser() async {
    Get.focusScope.unfocus();

    if (_formKey.currentState.validate()) {
      setState(NotifierState.isLoading);

      try {
        await Get.find<DataConnectionService>().checkConnection();

        SignInParams params = SignInParams(
          emailAddress: _emailAddressController.text.trim(),
          password: _passwordController.text,
        );

        AppUser user = await Get.find<AuthService>().signIn(params);

        setState(NotifierState.isIdle);

        Get.off(HomeScreen(user: user));
      } on Failure catch (f) {
        setState(NotifierState.isIdle);
        Get.snackbar(
          'Error',
          f.message,
          colorText: Get.theme.colorScheme.onError,
          backgroundColor: Get.theme.errorColor,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      setState(NotifierState.isIdle);
    }
  }

  void forgotPassword() async {}
}

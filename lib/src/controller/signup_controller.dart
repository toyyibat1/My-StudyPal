import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/signup_params.dart';
import '../services/auth_service/auth_service.dart';
import '../services/data_connection_service/data_connection_service.dart';
import '../views/screens/email_verifications_screen.dart';
import '../views/screens/signin_screen.dart';

class SignupController extends Notifier with ValidationMixin {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  Icon _icon = Icon(Icons.visibility);

  final _formKey = GlobalKey<FormState>();
  TapGestureRecognizer _signIn;

  bool get obscureText => _obscureText;
  Icon get icon => _icon;

  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get emailAddressController => _emailAddressController;
  TextEditingController get passwordController => _passwordController;

  TapGestureRecognizer get signIn => _signIn;
  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onInit() {
    _signIn = TapGestureRecognizer()
      ..onTap = () {
        Get.off(SigninScreen());
      };
    super.onInit();
  }

  void toggle() {
    setState(NotifierState.isIdle);
    _obscureText = !_obscureText;
    if (!_obscureText) {
      _icon = Icon(Icons.visibility_off);
    } else {
      _icon = Icon(Icons.visibility);
    }
  }

  void signupUser() async {
    Get.focusScope.unfocus();

    if (_formKey.currentState.validate()) {
      setState(NotifierState.isLoading);

      try {
        await Get.find<DataConnectionService>().checkConnection();

        SignupParams params = SignupParams(
          emailAddress: _emailAddressController.text.trim(),
          password: _passwordController.text,
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
        );

        await Get.find<AuthService>().signUp(params);

        setState(NotifierState.isIdle);

        Get.off(EmailVerificationScreen());
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

  void verifyAndContinue() async {
    Get.off(SigninScreen());
  }
}

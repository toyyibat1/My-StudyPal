import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/views/screens/create_account_screen.dart';
import 'package:my_study_pal/src/views/screens/forgot_password.dart';

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
  bool _obscureText = true;
  Icon _icon = Icon(Icons.visibility);

  final _formKey = GlobalKey<FormState>();
  TapGestureRecognizer _createAccount;
  TapGestureRecognizer _forgotPassword;

  bool get obscureText => _obscureText;
  Icon get icon => _icon;
  TextEditingController get emailAddressController => _emailAddressController;
  TextEditingController get passwordController => _passwordController;

  TapGestureRecognizer get createAccount => _createAccount;
  TapGestureRecognizer get forgotPassword => _forgotPassword;
  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onInit() {
    _createAccount = TapGestureRecognizer()
      ..onTap = () {
        Get.off(CreateAccountScreen());
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

  void forgotPasswordScreen() {
    Get.off(ForgotPasswordScreen());
  }
  // void forgotPassword() async {
  //   String emailAddress;
  //  // setState(NotifierState.isLoading);
  //   try{
  //     await Get.find<DataConnectionService>().checkConnection();

  //     ForgotPasswordParams params = ForgotPasswordParams(emailAddress: _emailAddressController.text.trim());
  //     await Get.find<AuthService>().forgotPassword(params);

  //    // setState(NotifierState.isIdle);
  //     Get.snackbar('Check Email', "Please Check your email to reset your password",
  //     colorText: Get.theme.colorScheme.onError,
  //     backgroundColor: Get.theme.primaryColor,
  //     snackPosition: SnackPosition.BOTTOM,);
  //     Get.off(SigninScreen());
  //   } on Failure catch(e){
  //    // setState(NotifierState.isIdle);
  //     Get.snackbar('Error',
  //     e.message,
  //     colorText: Get.theme.colorScheme.onError,
  //     backgroundColor: Get.theme.errorColor,
  //     snackPosition: SnackPosition.BOTTOM,);
  //   }
  // }

}

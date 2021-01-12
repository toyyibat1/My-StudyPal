import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/models/forgot_password_params.dart';
import 'package:my_study_pal/src/views/screens/signin_screen.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../services/auth_service/auth_service.dart';
import '../services/data_connection_service/data_connection_service.dart';

class ForgotPasswordController extends Notifier with ValidationMixin {
  final _emailAddressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  TextEditingController get emailAddressController => _emailAddressController;

  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onInit() {
    super.onInit();
  }

  void forgotPassword() async {
    Get.focusScope.unfocus();

    if (_formKey.currentState.validate()) {
    setState(NotifierState.isLoading);
    try{
      await Get.find<DataConnectionService>().checkConnection();

      ForgotPasswordParams params = ForgotPasswordParams(emailAddress: _emailAddressController.text.trim());
      await Get.find<AuthService>().forgotPassword(params);

      setState(NotifierState.isIdle);
      Get.snackbar('Email Sent', "Please Check your email to reset your password",
      colorText: Get.theme.colorScheme.onError,
      backgroundColor: Get.theme.primaryColor,
      snackPosition: SnackPosition.BOTTOM,);
      //Get.off(SigninScreen());
    } on Failure catch(e){
      setState(NotifierState.isIdle);
      Get.snackbar('Error',
      e.message,
      colorText: Get.theme.colorScheme.onError,
      backgroundColor: Get.theme.errorColor,
      snackPosition: SnackPosition.BOTTOM,);
    }
    }
  }
  
  void cancelForgotPassword(){
    Get.off(SigninScreen());
  }
}

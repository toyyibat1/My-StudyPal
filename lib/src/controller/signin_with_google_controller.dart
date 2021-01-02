import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/app_user.dart';
import '../services/auth_service/auth_service.dart';
import '../services/data_connection_service/data_connection_service.dart';
import '../views/screens/home_screen.dart';

class SigninWithGoogleController extends Notifier with ValidationMixin {
  //AppUser _user;

 // AppUser get user => _user;
  void signinUserWithGoogle() async {

      setState(NotifierState.isLoading);

      try {
        await Get.find<DataConnectionService>().checkConnection();
        //AppUser user = await Get.find<AuthService>().signIn(params);

        AppUser user = await Get.find<AuthService>().signInWithGoogle();

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


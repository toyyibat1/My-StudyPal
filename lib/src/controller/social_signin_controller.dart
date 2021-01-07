import 'package:get/get.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../models/app_user.dart';
import '../services/auth_service/auth_service.dart';
import '../services/data_connection_service/data_connection_service.dart';
import '../views/screens/home_screen.dart';

class SocialSigininController extends Notifier {
  void signinUserWithFacebook() async {
    setState(NotifierState.isLoading);
    try {
      await Get.find<DataConnectionService>().checkConnection();

      AppUser user = await Get.find<AuthService>().signInWithFacebook();

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

  void signUpUserWithFacebook() async {
    setState(NotifierState.isLoading);
    try {
      await Get.find<DataConnectionService>().checkConnection();

      AppUser user = await Get.find<AuthService>().signUpWithFacebook();

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

  void signinUserWithGoogle() async {
    setState(NotifierState.isLoading);

    try {
      await Get.find<DataConnectionService>().checkConnection();

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

  void signUpUserWithGoogle() async {
    setState(NotifierState.isLoading);

    try {
      await Get.find<DataConnectionService>().checkConnection();

      AppUser user = await Get.find<AuthService>().signUpWithGoogle();

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

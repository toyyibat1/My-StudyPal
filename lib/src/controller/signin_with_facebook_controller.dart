import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/views/screens/create_account_screen.dart';
import 'package:my_study_pal/src/views/screens/home_screen.dart';
import 'package:my_study_pal/src/views/screens/signin_screen.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/app_user.dart';
import '../services/auth_service/auth_service.dart';
import '../services/data_connection_service/data_connection_service.dart';

class SigninWithFacebookController extends Notifier with ValidationMixin {

  Map<String, dynamic> _userData;
  AccessToken _accessToken;

  // @override
  // void onInit() {
  //   _checkIfIsLogged(); 
  //   super.onInit();
  // }

  // Future<void> _checkIfIsLogged() async {
  //   final AccessToken accessToken = await FacebookAuth.instance.isLogged;
  //   setState(NotifierState.isIdle);
  //   if (accessToken != null) {
  //     print("is Logged:::: ${(accessToken.toJson())}");
  //     // now you can call to  FacebookAuth.instance.getUserData();
  //     final userData = await FacebookAuth.instance.getUserData();
  //     // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
  //     _accessToken = accessToken;
  //     onInit() {
  //       _userData = userData;
  //     }
  //   }
  // }

  void signinUserWithFacebook() async {
    setState(NotifierState.isLoading);
      try {  
        await Get.find<DataConnectionService>().checkConnection();
        AppUser user = await Get.find<AuthService>().signInWithFacebook();
        
        setState(NotifierState.isIdle);
        print(user);
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

        await Get.find<AuthService>().signUpWithFacebook();

        setState(NotifierState.isIdle);

        Get.off(SigninScreen());
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


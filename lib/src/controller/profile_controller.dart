import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/views/widgets/app_button.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/app_user.dart';
import '../services/auth_service/auth_service.dart';
import '../views/screens/badges_screen.dart';
import '../views/screens/create_account_screen.dart';
import '../views/screens/edit_profile_screen.dart';
import '../views/screens/focus_mode_screen.dart';
import '../views/screens/invite_friends_screen.dart';
import '../views/screens/school_schedule_screen.dart';
import '../views/screens/signin_screen.dart';
import '../views/screens/study_goal_screen.dart';

class ProfileController extends Notifier with ValidationMixin {
  AppUser _user;

  AppUser get user => _user;

  FutureOr onGoBack(dynamic value) async {
    getAuthenticatedUser();
    update();
  }

  void getAuthenticatedUser() async {
    setState(NotifierState.isLoading);
    try {
      _user = await Get.find<AuthService>().getAuthenticatedUser();

      setState(NotifierState.isIdle);
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
  }

  void navigateToEditProfileScreen() =>
      Get.to(EditProfileScreen(user: user)).then((onGoBack));

  void navigateToBadgesScreen() => Get.to(BadgesScreen());

  void navigateToStudyGoalsScreen() => Get.to(StudyGoalScreen());

  void navigateToAddScheduleScreen() => Get.to(SchoolScheduleScreen());

  void navigateToInviteFriendScreen() => Get.to(InviteFriendScreen());

  void navigateToFocusModeScreen() => Get.to(FocusModeScreen());

  void signOut() async {
    await Get.find<AuthService>().signOut();
    Get.offAll(SigninScreen());
  }

  void confirmSignOut() {
    Get.defaultDialog(
      title: "Signing out",
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: Text(
            "Hey ${_user.firstName}, Are you sure you want to exit the app?"),
      ),
//      onConfirm: signOut,
//      onCancel: Get.back,
      actions: [
        AppButton(
            onPressed: () {
              signOut();
//              signOutWithFacebook();
//              signOutWithGoogle();
            },
            label: "Yes"),
        AppButton(onPressed: () => Get.back(), label: "No"),
      ],
    );
  }

  void signOutWithGoogle() async {
    await Get.find<AuthService>().signOutWithGoogle();
    Get.offAll(CreateAccountScreen());
  }

  void signOutWithFacebook() async {
    await Get.find<AuthService>().signOutWithFacebook();
    Get.offAll(CreateAccountScreen());
  }
}

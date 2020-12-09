import 'dart:async';

import 'package:get/get.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/app_user.dart';
import '../services/auth_service/auth_service.dart';
import '../views/screens/badges_screen.dart';
import '../views/screens/edit_profile_screen.dart';
import '../views/screens/invite_friends_screen.dart';
import '../views/screens/school_schedule_screen.dart';
import '../views/screens/signin_screen.dart';
import '../views/screens/study_goals.dart';

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

  void navigateToStudyGoalsScreen() => Get.to(StudyGoalsScreen());

  void navigateToAddScheduleScreen() => Get.to(SchoolScheduleScreen());

  void navigateToInviteFriendScreen() => Get.to(InviteFriendScreen());

  void signOut() async {
    await Get.find<AuthService>().signOut();
    Get.off(SigninScreen());
  }
}

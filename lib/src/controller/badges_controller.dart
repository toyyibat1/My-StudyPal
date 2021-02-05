import 'dart:async';

import 'package:get/get.dart';
import 'package:my_study_pal/src/models/badges.dart';
import 'package:my_study_pal/src/models/badges_params.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../models/app_user.dart';
import '../models/task.dart';
import '../services/auth_service/auth_service.dart';
import '../services/database_service/database_service.dart';
import 'local_notification_controller.dart';

class BadgeController extends Notifier {
  AppUser _user;

  AppUser get user => _user;

  List<Badge> _badges = [];

  List<Badge> get badges => _badges;

  List<CompletedTaskBadges> _completedTaskBadges = [];

  List<CompletedTaskBadges> get completedTaskBadges => _completedTaskBadges;

  @override
  void onInit() {
    getCompletedTaskBadges();
    getAllBadges();
    super.onInit();
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

  FutureOr onGoBack(dynamic value) async {
    getCompletedTaskBadges();
    getAllBadges();
    update();
  }


   void getCompletedTaskBadges() async {
    setState(NotifierState.isLoading);
    try {
      _completedTaskBadges = await Get.find<DatabaseService>().getCompletedTaskBadges();
      print(completedTaskBadges.length);
    
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
    setState(NotifierState.isIdle);
  }

  void getAllBadges() async {
    setState(NotifierState.isLoading);
    try {
      _badges = await Get.find<DatabaseService>().getAllBadges();
      print(_badges.length);

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
    setState(NotifierState.isIdle);
  }

  void createBadge() async {
    String badgeTitle = "Task Ace";
    String descriptions = "Well-done, Padi! You just completed your first two tasks!";
        
      if((completedTaskBadges.length == 2)){    
       // await Get.find<DataConnectionService>().checkConnection();
        await notificationPlugin.showNotification(badgeTitle, descriptions, "");
        BadgesParams params =
            BadgesParams(badgeTitle: badgeTitle,
            desc: descriptions);

       await Get.find<DatabaseService>().createBadges(params);

      } else if(completedTaskBadges.length == 10) {
        String badgeTitle = "Task Skipper";
        String descriptions = "Impressive, Padi! You completed 10 tasks!";
        await notificationPlugin.showNotification(badgeTitle, descriptions, "");
      } else {
        return null;
      }
  }

}

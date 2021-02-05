import 'dart:async';

import 'package:get/get.dart';
import 'package:my_study_pal/src/models/badges.dart';
import 'package:my_study_pal/src/models/badges_params.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/badges.dart';
import '../models/app_user.dart';
import '../models/task.dart';
import '../services/auth_service/auth_service.dart';
import '../services/database_service/database_service.dart';
import 'local_notification_controller.dart';

class DashboardController extends Notifier {
  AppUser _user;

  AppUser get user => _user;

  List<Task> _pendingTasks = [];
  List<Task> _completedTasks = [];
  List<CompletedTaskBadges> _completedTaskBadges = [];

  List<Task> get pendingTasks => _pendingTasks;
  List<Task> get completedTasks => _completedTasks;
  List<CompletedTaskBadges> get completedTaskBadges => _completedTaskBadges;

  @override
  void onInit() {
    getPendingTasks();
    getCompletedTasks();
    getCompletedTaskBadges();
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
    getPendingTasks();
    getCompletedTasks();
    getCompletedTaskBadges();
    update();
  }

  void changeTaskStatus(String taskId, bool newStatus) async {
    setState(NotifierState.isLoading);
    try {
      Get.defaultDialog(
        title: 'Loading',
        middleText: 'Please Wait',
        barrierDismissible: false,
      ).then(onGoBack);

      if(newStatus == true){
        CompletedTaskBadgesParams completedtaskBadgesParams =
            CompletedTaskBadgesParams(completedtaskBadges: "CompletedTask Created");

      await Get.find<DatabaseService>().completedTaskBadges(completedtaskBadgesParams);
        
      if(_completedTaskBadges.length == 1){    
        
        BadgesParams params =
            BadgesParams(badgeTitle: complete2TaskBadgeTitle,
            desc: complete2TaskDescription);

       await Get.find<DatabaseService>().createBadges(params);
       await notificationPlugin.showNotification(complete2TaskBadgeTitle, complete2TaskDescription, "");
      } else if(_completedTaskBadges.length == 9) {
        
        BadgesParams params =
            BadgesParams(badgeTitle: complete10TaskBadgeTitle,
            desc: complete10TaskDescription);

       await Get.find<DatabaseService>().createBadges(params);
       await notificationPlugin.showNotification(complete10TaskBadgeTitle, complete10TaskDescription, "");
      }
        else if(_completedTaskBadges.length == 24) {
        BadgesParams params =
            BadgesParams(badgeTitle: complete25TaskBadgeTitle,
            desc: complete25TaskDescription);

       await Get.find<DatabaseService>().createBadges(params);
       await notificationPlugin.showNotification(complete25TaskBadgeTitle, complete25TaskDescription, "");
        }
        else if(_completedTaskBadges.length == 49) {
        BadgesParams params =
            BadgesParams(badgeTitle: complete50TaskBadgeTitle,
            desc: complete50TaskDescription);

       await Get.find<DatabaseService>().createBadges(params);
       await notificationPlugin.showNotification(complete50TaskBadgeTitle, complete50TaskDescription, "");
        }
        else if(_completedTaskBadges.length == 99) {
        BadgesParams params =
            BadgesParams(badgeTitle: complete100TaskBadgeTitle,
            desc: complete100TaskDescription);

       await Get.find<DatabaseService>().createBadges(params);
       await notificationPlugin.showNotification(complete100TaskBadgeTitle, complete100TaskDescription, "");
        }
        else {
          print("false");
        }
      } else {
        print("false");
      }   


      await Get.find<DatabaseService>().changeTaskStatus(taskId, newStatus);

      Get.back();
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

  void getPendingTasks() async {
    setState(NotifierState.isLoading);
    try {
      _pendingTasks = await Get.find<DatabaseService>().getPendingTasks();

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
   void getCompletedTaskBadges() async {
    setState(NotifierState.isLoading);
    try {
      _completedTaskBadges = await Get.find<DatabaseService>().getCompletedTaskBadges();
      print(_completedTaskBadges);
      // if(completedTaskBadges.length == 2){
      //   await notificationPlugin.showNotification("Task completed", "Badged", "");
      // } else if(completedTasks.length == 10) {
      //   await notificationPlugin.showNotification("Task completed", "Badged", "");
      // } else {
      //   return null;
      // }
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

  void getCompletedTasks() async {
    setState(NotifierState.isLoading);
    try {
      _completedTasks = await Get.find<DatabaseService>().getCompletedTasks();

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
}

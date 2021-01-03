import 'dart:async';

import 'package:get/get.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../models/app_user.dart';
import '../models/task.dart';
import '../services/auth_service/auth_service.dart';
import '../services/database_service/database_service.dart';

class DashboardController extends Notifier {
  AppUser _user;

  AppUser get user => _user;

  List<Task> _pendingTasks = [];
  List<Task> _completedTasks = [];

  List<Task> get pendingTasks => _pendingTasks;
  List<Task> get completedTasks => _completedTasks;

  @override
  void onInit() {
    getPendingTasks();
    getCompletedTasks();
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

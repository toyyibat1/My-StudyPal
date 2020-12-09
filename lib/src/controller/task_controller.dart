import 'dart:async';

import 'package:get/get.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../models/task.dart';
import '../services/database/database_service.dart';
import '../views/screens/create_task_screen.dart';
import '../views/screens/task_info_screen.dart';

class TaskController extends Notifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  @override
  void onInit() {
    getAllTasks();
    super.onInit();
  }

  FutureOr onGoBack(dynamic value) async {
    getAllTasks();
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

  void getAllTasks() async {
    setState(NotifierState.isLoading);
    try {
      _tasks = await Get.find<DatabaseService>().getAllTasks();

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

  void navigateToCreateTask() => Get.to(CreateTaskScreen()).then(onGoBack);

  void openTaskInfoScreen(Task task) {
    Get.bottomSheet(TaskInfoScreen(
      task: task,
      onGoBackCallback: onGoBack,
    )).then((onGoBack));
  }
}

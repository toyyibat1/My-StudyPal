import 'package:get/get.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../models/task.dart';
import '../services/database_service/database_service.dart';
import '../views/screens/edit_task_screen.dart';

class TaskInfoController extends Notifier {
  TaskInfoController(this.onGoBackCallback);
  final Function onGoBackCallback;

  void navigateToEditTask(Task task) => Get.off(
        EditTaskScreen(task: task),
      ).then(onGoBackCallback);

  void deleteTask(String taskId) async {
    setState(NotifierState.isLoading);
    try {
      await Get.find<DatabaseService>().deleteTask(taskId);

      setState(NotifierState.isIdle);

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
}

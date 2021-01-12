import 'package:get/get.dart';
import 'package:my_study_pal/src/controller/local_notification_controller.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../models/study_goal.dart';
import '../services/database_service/database_service.dart';
import '../views/screens/edit_study_goal_screen.dart';

class StudyGoalInfoController extends Notifier {
  StudyGoalInfoController(this.onGoBackCallback, this.studyGoal);
  final Function onGoBackCallback;
  final StudyGoal studyGoal;

  void navigateToEditStudyGoal(StudyGoal studyGoal) => Get.off(
        EditStudyGoalScreen(studyGoal: studyGoal),
      ).then(onGoBackCallback);

  void deleteStudyGoal(String studyGoalId) async {
    setState(NotifierState.isLoading);
    try {
      int id = studyGoal.timestamp.nanoseconds;
      await notificationPlugin.cancelNotification(id);
      await Get.find<DatabaseService>().deleteStudyGoal(studyGoalId);

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

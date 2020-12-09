import 'package:get/get.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../models/study_goal.dart';
import '../services/database/database_service.dart';
import '../views/screens/edit_study_goal_screen.dart';

class StudyGoalInfoController extends Notifier {
  StudyGoalInfoController(this.onGoBackCallback);
  final Function onGoBackCallback;

  void navigateToEditStudyGoal(StudyGoal studyGoal) => Get.off(
        EditStudyGoalScreen(studyGoal: studyGoal),
      ).then(onGoBackCallback);

  void deleteStudyGoal(String studyGoalId) async {
    setState(NotifierState.isLoading);
    try {
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

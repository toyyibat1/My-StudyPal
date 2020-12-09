import 'dart:async';

import 'package:get/get.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../models/study_goal.dart';
import '../services/database/database_service.dart';
import '../views/screens/create_study_goal_screen.dart';
import '../views/screens/study_goal_info_screen.dart';

class StudyGoalController extends Notifier {
  List<StudyGoal> _studyGoals = [];

  List<StudyGoal> get studyGoals => _studyGoals;

  @override
  void onInit() {
    getAllStudyGoals();
    super.onInit();
  }

  FutureOr onGoBack(dynamic value) async {
    getAllStudyGoals();
    update();
  }

  void getAllStudyGoals() async {
    setState(NotifierState.isLoading);
    try {
      _studyGoals = await Get.find<DatabaseService>().getAllStudyGoals();

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

  void navigateToCreateStudyGoal() =>
      Get.to(CreateStudyGoalScreen()).then(onGoBack);

  void openStudyGoalInfoScreen(StudyGoal studyGoal) {
    Get.bottomSheet(StudyGoalInfoScreen(
      studyGoal: studyGoal,
      onGoBackCallback: onGoBack,
    )).then((onGoBack));
  }
}

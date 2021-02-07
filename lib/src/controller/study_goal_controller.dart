import 'dart:async';

import 'package:get/get.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../models/study_goal.dart';
import '../services/database_service/database_service.dart';
import '../views/screens/create_study_goal_screen.dart';
import '../views/screens/study_goal_info_screen.dart';
import 'package:my_study_pal/src/models/badges.dart';


class StudyGoalController extends Notifier {
  List<StudyGoal> _studyGoals = [];

  List<StudyGoal> get studyGoals => _studyGoals;

  //badges 
  List<StudyGoalBadges> _studyGoalBadges = [];

  List<StudyGoalBadges> get studyGoalBadges  => _studyGoalBadges;

  @override
  void onInit() {
    getAllStudyGoals();
    getAllStudyGoalBadges();
    super.onInit();
  }

  FutureOr onGoBack(dynamic value) async {
    getAllStudyGoals();
    getAllStudyGoalBadges();
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
    Get.bottomSheet(
      StudyGoalInfoScreen(
        studyGoal: studyGoal,
        onGoBackCallback: onGoBack,
      ),
      isScrollControlled: true,
    ).then((onGoBack));
  }

  void getAllStudyGoalBadges() async {
    setState(NotifierState.isLoading);
    try {
      _studyGoalBadges = await Get.find<DatabaseService>().getAllStudyGoalBadges();
      print(_studyGoalBadges);

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

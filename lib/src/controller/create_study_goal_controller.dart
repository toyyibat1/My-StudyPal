import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_study_pal/src/controller/local_notification_controller.dart';
import 'package:my_study_pal/src/models/badges_params.dart';
import 'package:my_study_pal/src/models/study_goal.dart';
import 'package:my_study_pal/src/services/database_service/database_service.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/study_goal_params.dart';
import '../services/data_connection_service/data_connection_service.dart';

class CreateStudyGoalController extends Notifier with ValidationMixin {
  DateTime _pickedDate;

  final _dateController = TextEditingController();
  final _goalController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  TextEditingController get dateController => _dateController;
  TextEditingController get goalController => _goalController;

  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onInit() {
    _pickedDate = DateTime.now();

    super.onInit();
  }

  Future<Null> selectDate(BuildContext context) async {
    Get.focusScope.unfocus();

    DateTime _date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: _pickedDate,
    );

    if (_date != null) {
      _pickedDate = _date;
      _dateController.text = DateFormat.yMMMMEEEEd().format(_pickedDate);
      update();
    }
  }

  void goBack() => Get.back();

  void createStudyGoal() async {
    Get.focusScope.unfocus();

    if (_formKey.currentState.validate()) {
      setState(NotifierState.isLoading);

      try {
        await Get.find<DataConnectionService>().checkConnection();

        StudyGoalParams params = StudyGoalParams(
          goal: _goalController.text,
          date: _pickedDate,
        );
        StudyGoalBadgesParams studyGoalBadgesParams =
            StudyGoalBadgesParams(studyGoalBadges: "StudyGoal Created");

        StudyGoal studyGoal =
            await Get.find<DatabaseService>().createStudyGoal(params);

        await Get.find<DatabaseService>()
            .createStudyGoalBadges(studyGoalBadgesParams);
        int id = studyGoal.timestamp.nanoseconds;

        await notificationPlugin.scheduleNotification(
            id,
            ' Study Goal Reminder',
            params.goal,
            params.date,
            'Study Goal Reminder');

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
}

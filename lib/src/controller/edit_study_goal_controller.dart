import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_study_pal/src/controller/local_notification_controller.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/study_goal.dart';
import '../models/study_goal_params.dart';
import '../services/data_connection_service/data_connection_service.dart';
import '../services/database_service/database_service.dart';

class EditStudyGoalController extends Notifier with ValidationMixin {
  EditStudyGoalController(this.studyGoal);
  final StudyGoal studyGoal;

  DateTime _pickedDate;

  final _dateController = TextEditingController();
  final _goalController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  TextEditingController get dateController => _dateController;
  TextEditingController get goalController => _goalController;

  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onInit() {
    _goalController.text = studyGoal.goal;
    _pickedDate = studyGoal.date;
    _dateController.text = DateFormat.yMMMMEEEEd().format(_pickedDate);

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

  void updateStudyGoal(String studyGoalId) async {
    Get.focusScope.unfocus();

    if (_formKey.currentState.validate()) {
      setState(NotifierState.isLoading);

      try {
        await Get.find<DataConnectionService>().checkConnection();

        StudyGoalParams params = StudyGoalParams(
          goal: _goalController.text,
          date: _pickedDate,
        );

        await Get.find<DatabaseService>().updateStudyGoal(studyGoalId, params);
        int id = studyGoal.timestamp.nanoseconds;
        await notificationPlugin.cancelNotification(id);
        await notificationPlugin.scheduleNotification(id, 'Study Goal Reminder',
            params.goal, params.date, 'Study Goal Reminder');

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

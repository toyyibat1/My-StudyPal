import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_study_pal/src/controller/local_notification_controller.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/school_schedule.dart';
import '../models/school_schedule_params.dart';
import '../services/data_connection_service/data_connection_service.dart';
import '../services/database/database_service.dart';

class EditSchoolScheduleController extends Notifier with ValidationMixin {
  EditSchoolScheduleController(this.schedule);
  final SchoolSchedule schedule;

  DateTime _startOfSemester;
  DateTime _endOfSemester;

  final _startOfSemesterController = TextEditingController();
  final _endOfSemesterController = TextEditingController();
  final _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  TextEditingController get startOfSemesterController =>
      _startOfSemesterController;
  TextEditingController get endOfSemesterController => _endOfSemesterController;
  TextEditingController get nameController => _nameController;

  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onInit() {
    _nameController.text = schedule.name;
    _startOfSemester = schedule.startOfSemester;
    _endOfSemester = schedule.endOfSemester;
    _startOfSemesterController.text =
        DateFormat.yMMMMEEEEd().format(_startOfSemester);
    _endOfSemesterController.text =
        DateFormat.yMMMMEEEEd().format(_endOfSemester);

    super.onInit();
  }

  Future<Null> selectStartDate(BuildContext context) async {
    Get.focusScope.unfocus();

    DateTime _date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: _startOfSemester,
    );

    if (_date != null) {
      _startOfSemester = _date;
      _startOfSemesterController.text =
          DateFormat.yMMMMEEEEd().format(_startOfSemester);
      update();
    }
  }

  Future<Null> selectEndDate(BuildContext context) async {
    Get.focusScope.unfocus();

    DateTime _date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: _endOfSemester,
    );

    if (_date != null) {
      _endOfSemester = _date;
      _endOfSemesterController.text =
          DateFormat.yMMMMEEEEd().format(_endOfSemester);
      update();
    }
  }

  void goBack() => Get.back();

  void updateSchedule(String scheduleId) async {
    Get.focusScope.unfocus();

    if (_formKey.currentState.validate()) {
      setState(NotifierState.isLoading);

      try {
        await Get.find<DataConnectionService>().checkConnection();

        SchoolScheduleParams params = SchoolScheduleParams(
          endOfSemester: _endOfSemester,
          startOfSemester: _startOfSemester,
          name: _nameController.text,
        );

        await Get.find<DatabaseService>().updateSchedule(scheduleId, params);
        await notificationPlugin.scheduleNotification(
            params.name,
            params.startOfSemester.toString(),
            params.startOfSemester,
            'Schedule Reminder');

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

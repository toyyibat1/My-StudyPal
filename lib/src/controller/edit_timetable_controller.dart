import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/timetable.dart';
import '../models/timetable_params.dart';
import '../services/data_connection_service/data_connection_service.dart';
import '../services/database_service/database_service.dart';

class EditTimetableController extends Notifier with ValidationMixin {
  EditTimetableController(this.timetable);
  final Timetable timetable;

  TimeOfDay _pickedStartTime;
  TimeOfDay _pickedEndTime;

  final _timetableSubjectController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _timetableLocationController = TextEditingController();
  final _timetableDayController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  TextEditingController get timetableSubjectController =>
      _timetableSubjectController;
  TextEditingController get timetableDayController => _timetableDayController;
  TextEditingController get timetableLocationController =>
      _timetableLocationController;
  TextEditingController get startTimeController => _startTimeController;
  TextEditingController get endTimeController => _endTimeController;

  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onInit() {
    _pickedStartTime = timetable.startTime;
    _pickedEndTime = timetable.endTime;
    _timetableDayController.text = timetable.day;
    _timetableSubjectController.text = timetable.subject;
    _timetableLocationController.text = timetable.location;

    super.onInit();
  }

  void formatTimes(BuildContext context) {
    _startTimeController.text = timetable.startTime.format(context);
    _endTimeController.text = timetable.endTime.format(context);
  }

  Future<Null> selectStartTime(BuildContext context) async {
    Get.focusScope.unfocus();

    TimeOfDay _time = await showTimePicker(
      context: context,
      initialTime: _pickedStartTime,
    );

    if (_time != null) {
      _pickedStartTime = _time;
      _startTimeController.text = _pickedStartTime.format(context);
      update();
    }
  }

  Future<Null> selectEndTime(BuildContext context) async {
    Get.focusScope.unfocus();

    TimeOfDay _time = await showTimePicker(
      context: context,
      initialTime: _pickedEndTime,
    );

    if (_time != null) {
      _pickedEndTime = _time;
      _endTimeController.text = _pickedEndTime.format(context);
      update();
    }
  }

  void goBack() => Get.back();

  void updateTimetable(String timetableId) async {
    Get.focusScope.unfocus();

    if (_formKey.currentState.validate()) {
      setState(NotifierState.isLoading);

      try {
        await Get.find<DataConnectionService>().checkConnection();

        TimetableParams params = TimetableParams(
          subject: _timetableSubjectController.text,
          day: _timetableDayController.text,
          endTime: _pickedEndTime,
          location: _timetableLocationController.text,
          startTime: _pickedStartTime,
        );

        await Get.find<DatabaseService>().updateTimetable(timetableId, params);

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

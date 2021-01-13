import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/dateTimeUtils.dart';
import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/timetable.dart';
import '../models/timetable_params.dart';
import '../services/data_connection_service/data_connection_service.dart';
import '../services/database_service/database_service.dart';
import 'local_notification_controller.dart';

class CreateTimetableController extends Notifier with ValidationMixin {
  TimeOfDay _pickedStartTime;
  TimeOfDay _pickedEndTime;

  final _timetableSubjectController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _timetableLocationController = TextEditingController();
  final _timetableDayController = TextEditingController();
  final _notificationTime = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  int _radioValue;

  TextEditingController get timetableSubjectController =>
      _timetableSubjectController;
  TextEditingController get timetableDayController => _timetableDayController;
  TextEditingController get timetableLocationController =>
      _timetableLocationController;
  TextEditingController get startTimeController => _startTimeController;
  TextEditingController get endTimeController => _endTimeController;
  TextEditingController get notificationTime => _notificationTime;

  GlobalKey<FormState> get formKey => _formKey;
  int get radioValue => _radioValue;

  @override
  void onInit() {
    _pickedStartTime = TimeOfDay.now();
    _pickedEndTime = TimeOfDay.now();
    _timetableDayController.text = 'Monday';
    super.onInit();
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

  Future<Null> selectNotificationTime(BuildContext context) async {
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

  void changeRadio(value) {
    setState(NotifierState.isIdle);
    _radioValue = value;
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

  void createTimetable() async {
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
        Timetable timetable =
            await Get.find<DatabaseService>().createTimetable(params);

        int id = timetable.timestamp.nanoseconds;

        TimeOfDay startTime;
//Before Start time
        if (_radioValue == 0) {
          startTime = plusMinutes(params.startTime, 16);
        } else if (_radioValue == 1) {
          startTime = plusMinutes(params.startTime, 31);
        } else if (_radioValue == 2) {
          startTime = plusMinutes(params.startTime, 61);
        } else if (_radioValue.isNull) {
          startTime = plusMinutes(params.startTime, 0);
        } else {
          startTime = plusMinutes(params.startTime, 0);
        }

        await notificationPlugin.weeklyNotification(
          id,
          params.day,
          params.subject,
          startDayTimeTable(params),
          startTimeTimetable(startTime),
          'Timetable Reminder',
        );

// Exact Start time
        if (_radioValue == 0) {
          startTime = plusMinutes(params.startTime, 0);
        } else if (_radioValue == 1) {
          startTime = plusMinutes(params.startTime, 0);
        } else if (_radioValue == 2) {
          startTime = plusMinutes(params.startTime, 0);
        } else {
          startTime = plusMinutes(params.startTime, 0);
        }
        await notificationPlugin.weeklyNotification(
          id + 4,
          params.day,
          params.subject,
          startDayTimeTable(params),
          startTimeTimetable(startTime),
          'Timetable Reminder',
        );
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

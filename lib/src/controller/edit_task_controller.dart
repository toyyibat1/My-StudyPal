import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../core/dateTimeUtils.dart';
import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/task.dart';
import '../models/task_params.dart';
import '../services/data_connection_service/data_connection_service.dart';
import '../services/database_service/database_service.dart';
import 'local_notification_controller.dart';

class EditTaskController extends Notifier with ValidationMixin {
  EditTaskController(this.task);
  final Task task;

  TimeOfDay _pickedStartTime;
  TimeOfDay _pickedEndTime;
  DateTime _pickedDate;

  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  TextEditingController get taskNameController => _taskNameController;
  TextEditingController get taskDescriptionController =>
      _taskDescriptionController;
  TextEditingController get dateController => _dateController;
  TextEditingController get startTimeController => _startTimeController;
  TextEditingController get endTimeController => _endTimeController;

  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onInit() {
    _pickedStartTime = task.startTime;
    _pickedEndTime = task.endTime;
    _pickedDate = task.date;
    _taskNameController.text = task.name;
    _taskDescriptionController.text = task.description;
    _dateController.text = DateFormat.yMMMMEEEEd().format(_pickedDate);

    super.onInit();
  }

  void formatTimes(BuildContext context) {
    _startTimeController.text = task.startTime.format(context);
    _endTimeController.text = task.endTime.format(context);
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

  Future<void> updateTask(String taskId) async {
    Get.focusScope.unfocus();

    if (_formKey.currentState.validate()) {
      setState(NotifierState.isLoading);

      try {
        await Get.find<DataConnectionService>().checkConnection();

        TaskParams params = TaskParams(
          date: _pickedDate,
          description: _taskDescriptionController.text,
          endTime: _pickedEndTime,
          name: _taskNameController.text,
          startTime: _pickedStartTime,
        );

        await Get.find<DatabaseService>().updateTask(taskId, params);
        int id = task.timestamp.nanoseconds;

        // cancels start notification
        await notificationPlugin.cancelNotification(id);
        // cancels end notification
        await notificationPlugin.cancelNotification(id + 1);

        // updates start notification
        await notificationPlugin.scheduleNotification(
          id,
          params.name,
          params.description,
          startTimeTask(params),
          'Task Reminder',
        );
        // updates end notification
        await notificationPlugin.scheduleNotification(
          id + 1,
          params.name,
          params.description,
          endTimeTask(params),
          'Task Reminder',
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

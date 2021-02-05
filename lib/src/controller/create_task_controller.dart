import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_study_pal/src/models/badges.dart';
import 'package:my_study_pal/src/models/badges_params.dart';

import '../core/dateTimeUtils.dart';
import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/task.dart';
import '../models/task_params.dart';
import '../services/data_connection_service/data_connection_service.dart';
import '../services/database_service/database_service.dart';
import 'local_notification_controller.dart';

class CreateTaskController extends Notifier with ValidationMixin {
  TimeOfDay _pickedStartTime;
  TimeOfDay _pickedEndTime;
  DateTime _pickedDate;

//  badges
  List<TaskBadges> _tasksBadges = [];
  List<TaskBadges> get tasksBadges => _tasksBadges;

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
    _pickedStartTime = TimeOfDay.now();
    _pickedEndTime = TimeOfDay.now();
    _pickedDate = DateTime.now();
    getTaskBadges();
    super.onInit();
  }
  FutureOr onGoBack(dynamic value) async {
    getTaskBadges();
    update();
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

//  badges
  void getTaskBadges() async {
    _tasksBadges = await Get.find<DatabaseService>().getTaskBadges();
    if(_tasksBadges.length >= 2){
      print("taskBadges${_tasksBadges.length}");
    }
  }

  void createTask() async {
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
//        Converting Date time to integer
//        int startTaskValidate = startTimeTask(params).year +
//            startTimeTask(params).hour +
//            startTimeTask(params).minute;
//
//        int endTaskValidate = startTimeTask(params).year +
//            endTimeTask(params).hour +
//            endTimeTask(params).minute;
//
//        if (startTaskValidate < endTaskValidate) {
        TaskBadgesParams taskBadgesParams =
            TaskBadgesParams(taskBadges: "task Created");

        Task task = await Get.find<DatabaseService>().createTask(params);
        await Get.find<DatabaseService>().createTaskBadges(taskBadgesParams);

        int id = task.timestamp.nanoseconds;

        // Creates start notification
        await notificationPlugin.scheduleNotification(
          id,
          params.name,
          params.description,
          startTimeTask(params),
          'Task Reminder',
        );

        // Creates end notification
        await notificationPlugin.scheduleNotification(
          id + 1,
          params.name + ", Deadline Reached",
          params.description,
          endTimeTask(params),
          'Task Reminder',
        );
//        } else if (startTaskValidate == endTaskValidate) {

//          Get.snackbar(
//            'Error',
//            'Start time and end time cannot be the same',
//            colorText: Get.theme.colorScheme.onError,
//            backgroundColor: Get.theme.errorColor,
//            snackPosition: SnackPosition.BOTTOM,
//          );
//        } else if (startTaskValidate > endTaskValidate) {
//        print("startTaskValidate > endTaskValidate");
//        Get.snackbar(
//          'Error',
//          "End time must be later than start time",
//          colorText: Get.theme.colorScheme.onError,
//          backgroundColor: Get.theme.errorColor,
//          snackPosition: SnackPosition.BOTTOM,
//        );
//        }

//        setState(NotifierState.isIdle);
        print(_tasksBadges);
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

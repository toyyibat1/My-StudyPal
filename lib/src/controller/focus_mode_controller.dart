import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/core/dateTimeUtils.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/focus_mode_params.dart';
import '../services/data_connection_service/data_connection_service.dart';
import '../services/database_service/database_service.dart';

class FocusModeController extends Notifier with ValidationMixin {
  TimeOfDay _pickedStartTime;
  TimeOfDay _pickedEndTime;
  bool focusModeToggle = false;

  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  TextEditingController get startTimeController => _startTimeController;
  TextEditingController get endTimeController => _endTimeController;

  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onInit() {
    _pickedStartTime = TimeOfDay.now();
    _pickedEndTime = TimeOfDay.now();
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

  void onChange() {
    focusModeToggle = !focusModeToggle;
    print(focusModeToggle);
    setState(NotifierState.isIdle);
  }

  void updateUI() async {
    int filter = await FlutterDnd.getCurrentInterruptionFilter();
    String filterName = FlutterDnd.getFilterName(filter);
    bool isNotificationPolicyAccessGranted =
        await FlutterDnd.isNotificationPolicyAccessGranted;
    isNotificationPolicyAccessGranted = isNotificationPolicyAccessGranted;
    filterName = filterName;
  }

  Future<void> setInterruptionFilter(int filter) async {
    if (await FlutterDnd.isNotificationPolicyAccessGranted) {
      await FlutterDnd.setInterruptionFilter(filter);
      updateUI();
    }
  }

  void createFocusMode() async {
    Get.focusScope.unfocus();

    if (_formKey.currentState.validate()) {
      setState(NotifierState.isLoading);

      try {
        await Get.find<DataConnectionService>().checkConnection();

        FocusModeParams params = FocusModeParams(
          focusModeToggle: focusModeToggle,
          endTime: _pickedEndTime,
          startTime: _pickedStartTime,
        );

        
                  //        Converting Date time to integer
       int startTimeFocusModeValidate = startTimeFocusMode(params).year +
           startTimeFocusMode(params).hour +
           startTimeFocusMode(params).minute;

       int endTimeFocusModeValidate = endTimeFocusMode(params).year +
           endTimeFocusMode(params).hour +
           endTimeFocusMode(params).minute;

       if (startTimeFocusModeValidate < endTimeFocusModeValidate) {
         await Get.find<DatabaseService>().createFocusMode(params);

       } else if (startTimeFocusModeValidate == endTimeFocusModeValidate) {
         setState(NotifierState.isIdle);
         return Get.snackbar(
           'Error',
           'Start time and end time cannot be the same',
           colorText: Get.theme.colorScheme.onError,
           backgroundColor: Get.theme.errorColor,
           snackPosition: SnackPosition.BOTTOM,
         );
       // return setState(NotifierState.isIdle);
       } else if (startTimeFocusModeValidate > endTimeFocusModeValidate) {
       print("startTaskValidate > endTaskValidate");
       setState(NotifierState.isIdle);
       return Get.snackbar(
         'Error',
         "End time must be later than start time",
         colorText: Get.theme.colorScheme.onError,
         backgroundColor: Get.theme.errorColor,
         snackPosition: SnackPosition.BOTTOM,
       );
       
       }

        if (focusModeToggle) {
          if (await FlutterDnd.isNotificationPolicyAccessGranted) {
            if (DateTime(DateTime.now().hour, DateTime.now().minute) ==
                startTimeFocusMode(params)) {
              await setInterruptionFilter(FlutterDnd
                  .INTERRUPTION_FILTER_NONE); //Turn on DND - All notifications are suppressed.

            } else if (DateTime(DateTime.now().hour, DateTime.now().minute) ==
                endTimeFocusMode(params)) {
              setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALL);
            }
          } else {
            FlutterDnd.gotoPolicySettings();
          }
        } else {
          setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALL);
        }
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

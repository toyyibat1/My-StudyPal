import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:get/get.dart';

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

  @override
  void updateUI() async {
    int filter = await FlutterDnd.getCurrentInterruptionFilter();
    String filterName = FlutterDnd.getFilterName(filter);
    bool isNotificationPolicyAccessGranted =
        await FlutterDnd.isNotificationPolicyAccessGranted;
    isNotificationPolicyAccessGranted = isNotificationPolicyAccessGranted;
    filterName = filterName;
  }

  void setInterruptionFilter(int filter) async {
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
        await Get.find<DatabaseService>().createFocusMode(params);

        if (focusModeToggle) {
          if (await FlutterDnd.isNotificationPolicyAccessGranted) {
            if (TimeOfDay.now() == params.startTime) {
              setInterruptionFilter(FlutterDnd
                  .INTERRUPTION_FILTER_NONE); //       Turn on DND - All notifications are suppressed.

            } else if (TimeOfDay.now() == params.endTime) {
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

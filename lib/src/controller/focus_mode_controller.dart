import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/models/focus_mode_params.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../services/data_connection_service/data_connection_service.dart';
import '../services/database/database_service.dart';

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
        if (!focusModeToggle) {
          if (await FlutterDnd.isNotificationPolicyAccessGranted) {
            setInterruptionFilter(FlutterDnd
                .INTERRUPTION_FILTER_NONE); // Turn on DND - All notifications are suppressed.
          } else {
            FlutterDnd.gotoPolicySettings();
          }
        } else {
          _formKey.currentState.validate();
          setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALL);
        }
        await Get.find<DatabaseService>().createFocusMode(params);

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
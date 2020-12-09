import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/schedule_params.dart';
import '../services/data_connection_service/data_connection_service.dart';
import '../services/database/database_service.dart';

class CreateScheduleController extends Notifier with ValidationMixin {
  DateTime _pickedStartDate;
  DateTime _pickedEndDate;

  final _scheduleNameController = TextEditingController();
  final _startDateController = TextEditingController();
 final _endDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  TapGestureRecognizer _signUp;

  TextEditingController get scheduleNameController => _scheduleNameController;
  TextEditingController get startDateController => _startDateController;
  TextEditingController get endDateController => _endDateController;

  TapGestureRecognizer get signUp => _signUp;
  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onInit() {
    _pickedStartDate = DateTime.now();
    _pickedEndDate = DateTime.now();
    super.onInit();
  }

  Future<Null> selectStartDate(BuildContext context) async {
    Get.focusScope.unfocus();

    DateTime _date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: _pickedStartDate,
    );

    if (_date != null) {
      _pickedStartDate = _date;
      _startDateController.text = DateFormat.yMMMMEEEEd().format(_pickedStartDate);
      update();
    }
  }
  Future<Null> selectEndDate(BuildContext context) async {
    Get.focusScope.unfocus();

    DateTime _date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: _pickedEndDate,
    );

    if (_date != null) {
      _pickedEndDate = _date;
      _endDateController.text = DateFormat.yMMMMEEEEd().format(_pickedEndDate);
      update();
    }
  }


  void goBack() => Get.back();

  void createSchedule() async {
    Get.focusScope.unfocus();

    if (_formKey.currentState.validate()) {
      setState(NotifierState.isLoading);

      try {
        await Get.find<DataConnectionService>().checkConnection();

        ScheduleParams params = ScheduleParams(
          semesterName: _scheduleNameController.text,
          endDate: _pickedStartDate,
          startDate: _pickedEndDate
        );

        await Get.find<DatabaseService>().createSchedule(params);

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

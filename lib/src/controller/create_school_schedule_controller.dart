import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/school_schedule_params.dart';
import '../services/data_connection_service/data_connection_service.dart';
import '../services/database/database_service.dart';

class CreateSchoolScheduleController extends Notifier with ValidationMixin {
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
    _startOfSemester = DateTime.now();
    _endOfSemester = DateTime.now();

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

  void createSchedule() async {
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
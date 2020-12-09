import 'dart:async';

import 'package:get/get.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../models/schedule.dart';
import '../services/database/database_service.dart';
import '../views/screens/create_schedule_screen.dart';

class ScheduleController extends Notifier {
  List<Schedule> _schedules = [];

  List<Schedule> get schedules => _schedules;

  @override
  void onInit() {
    getAllSchedules();
    super.onInit();
  }

  FutureOr onGoBack(dynamic value) async {
    getAllSchedules();
    update();
  }

  void changeScheduleStatus(String scheduleId, bool newStatus) async {
    setState(NotifierState.isLoading);
    try {
      Get.defaultDialog(
        title: 'Loading',
        middleText: 'Please Wait',
        barrierDismissible: false,
      ).then(onGoBack);

      await Get.find<DatabaseService>().changeScheduleStatus(scheduleId, newStatus);

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

  void getAllSchedules() async {
    setState(NotifierState.isLoading);
    try {
      _schedules = await Get.find<DatabaseService>().getAllSchedules();

      setState(NotifierState.isIdle);
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

  void navigateToCreateSchedule() => Get.to(CreateScheduleScreen()).then(onGoBack);

  void goBack() => Get.back();
}

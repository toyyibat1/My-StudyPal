import 'dart:async';

import 'package:get/get.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../models/school_schedule.dart';
import '../services/database/database_service.dart';
import '../views/screens/create_school_schedule_screen.dart';
import '../views/screens/school_schedule_info_screen.dart';

class SchoolScheduleController extends Notifier {
  List<SchoolSchedule> _schedules = [];

  List<SchoolSchedule> get schedules => _schedules;

  @override
  void onInit() {
    getAllSchedules();
    super.onInit();
  }

  FutureOr onGoBack(dynamic value) async {
    getAllSchedules();
    update();
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

  void navigateToCreateSchedule() =>
      Get.to(CreateSchoolScheduleScreen()).then(onGoBack);

  void openScheduleInfoScreen(SchoolSchedule schedule) {
    Get.bottomSheet(SchoolScheduleInfoScreen(
      schedule: schedule,
      onGoBackCallback: onGoBack,
    )).then((onGoBack));
  }
}

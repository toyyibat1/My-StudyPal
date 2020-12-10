import 'package:get/get.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../models/school_schedule.dart';
import '../services/database/database_service.dart';
import '../views/screens/edit_school_schedule_screen.dart';

class SchoolScheduleInfoController extends Notifier {
  SchoolScheduleInfoController(this.onGoBackCallback);
  final Function onGoBackCallback;

  void navigateToEditSchoolSchedule(SchoolSchedule schedule) => Get.off(
        EditSchoolScheduleScreen(schedule: schedule),
      ).then(onGoBackCallback);

  void deleteSchedule(String scheduleId) async {
    setState(NotifierState.isLoading);
    try {
      await Get.find<DatabaseService>().deleteSchedule(scheduleId);

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

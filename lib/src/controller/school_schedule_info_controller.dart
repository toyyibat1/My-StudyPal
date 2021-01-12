import 'package:get/get.dart';
import 'package:my_study_pal/src/controller/local_notification_controller.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../models/school_schedule.dart';
import '../services/database_service/database_service.dart';
import '../views/screens/edit_school_schedule_screen.dart';

class SchoolScheduleInfoController extends Notifier {
  SchoolScheduleInfoController(this.onGoBackCallback, this.schedule);
  final Function onGoBackCallback;
  final SchoolSchedule schedule;

  void navigateToEditSchoolSchedule(SchoolSchedule schedule) => Get.off(
        EditSchoolScheduleScreen(schedule: schedule),
      ).then(onGoBackCallback);

  void deleteSchedule(String scheduleId) async {
    setState(NotifierState.isLoading);
    try {
      int id = schedule.timestamp.nanoseconds;
      //         Cancels start schedule
      await notificationPlugin.cancelNotification(id);
      //         Cancels end schedule

      await notificationPlugin.cancelNotification(id + 2);
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

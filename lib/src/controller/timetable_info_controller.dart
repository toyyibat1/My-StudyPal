import 'package:get/get.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../models/timetable.dart';
import '../services/database_service/database_service.dart';
import '../views/screens/edit_timetable_screen.dart';

class TimetableInfoController extends Notifier {
  TimetableInfoController(this.onGoBackCallback);
  final Function onGoBackCallback;

  void navigateToEditTimetable(Timetable timetable) => Get.off(
        EditTimetableScreen(timetable: timetable),
      ).then(onGoBackCallback);

  void deleteTimetable(String timetableId) async {
    setState(NotifierState.isLoading);
    try {
      await Get.find<DatabaseService>().deleteTimetable(timetableId);

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

import 'dart:async';

import 'package:get/get.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../models/timetable.dart';
import '../services/database/database_service.dart';
import '../views/screens/create_timetable_screen.dart';
import '../views/screens/timetable_info_screen.dart';

class TimetableController extends Notifier {
  List<Timetable> _timetables = [];

  List<Timetable> get timetables => _timetables;

  @override
  void onInit() {
    getAllTimetables();
    super.onInit();
  }

  FutureOr onGoBack(dynamic value) async {
    getAllTimetables();
    update();
  }

  void getAllTimetables() async {
    setState(NotifierState.isLoading);
    try {
      _timetables = await Get.find<DatabaseService>().getAllTimetables();

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

  void navigateToCreateTimetable() =>
      Get.to(CreateTimetableScreen()).then(onGoBack);

  void openTimetableInfoScreen(Timetable timetable) {
    Get.bottomSheet(
      TimetableInfoScreen(
        timetable: timetable,
        onGoBackCallback: onGoBack,
      ),
      isScrollControlled: true,
    ).then((onGoBack));
  }
}

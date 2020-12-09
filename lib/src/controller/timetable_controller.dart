import 'dart:async';

import 'package:get/get.dart';
import 'package:my_study_pal/src/models/timetable.dart';
import 'package:my_study_pal/src/views/screens/create_timetable_screen.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../services/database/database_service.dart';

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

  void goBack() => Get.back();
}

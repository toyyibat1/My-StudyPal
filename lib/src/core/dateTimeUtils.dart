import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../models/focus_mode_params.dart';
import '../models/school_schedule_params.dart';
import '../models/study_goal_params.dart';
import '../models/task_params.dart';
import '../models/timetable.dart';
import '../models/timetable_params.dart';
import 'failure.dart';

Timetable timetable;
int dayValue = 1;
Day day = Day(dayValue);
Time time = Time();

//Task
DateTime startTimeTask(TaskParams params) => DateTime(
      params.date.year,
      params.date.month,
      params.date.day,
      params.startTime.hour,
      params.startTime.minute,
    );

DateTime endTimeTask(TaskParams params) => DateTime(
      params.date.year,
      params.date.month,
      params.date.day,
      params.endTime.hour,
      params.endTime.minute,
    );

//Timetable
DateTime date = DateTime.now();

DateTime startTimeTable(TimetableParams params) => DateTime(
      date.year,
      date.month,
      date.day,
      params.startTime.hour,
      params.startTime.minute,
    );

DateTime endTimeTable(TimetableParams params) => DateTime(
      date.year,
      date.month,
      date.day,
      params.endTime.hour,
      params.endTime.minute,
    );

Day startDayTimeTable(notificationDay, TimetableParams params) {
  try {
    if (params.day == "Sunday") {
      dayValue = 1;
    } else if (params.day == "Monday") {
      dayValue = 2;
    } else if (params.day == "Tuesday") {
      dayValue = 3;
    } else if (params.day == "Wednesday") {
      dayValue = 4;
    } else if (params.day == "Thursday") {
      dayValue = 5;
    } else if (params.day == "Friday") {
      dayValue = 6;
    } else if (params.day == "Saturday") {
      dayValue = 6;
    } else {
      dayValue = 2;
    }
  } on Failure catch (f) {
    Get.snackbar(
      'Error',
      f.message,
      colorText: Get.theme.colorScheme.onError,
      backgroundColor: Get.theme.errorColor,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  return Day(dayValue);
}

Time startTimeTimetable(notificationTime, TimetableParams params) => Time(
      params.startTime.hour,
      params.startTime.minute,
    );

//FocusMode
DateTime endTimeFocusMode(FocusModeParams params) => DateTime(
      params.endTime.hour,
      params.endTime.minute,
    );

DateTime startTimeFocusMode(date, FocusModeParams params) => DateTime(
      params.startTime.hour,
      params.startTime.minute,
    );

//StudyGoal
DateTime dateStudyGoal(StudyGoalParams params) => DateTime(
      date.year,
      date.month,
      date.day,
    );

//School Schedule
DateTime startSchoolSchedule(SchoolScheduleParams params) => DateTime(
      params.startOfSemester.year,
      params.startOfSemester.month,
      params.startOfSemester.day,
    );

DateTime endSchoolSchedule(SchoolScheduleParams params) => DateTime(
      params.endOfSemester.year,
      params.endOfSemester.month,
      params.endOfSemester.day,
    );

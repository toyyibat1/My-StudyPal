import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../models/focus_mode_params.dart';
import '../models/school_schedule_params.dart';
import '../models/study_goal_params.dart';
import '../models/task_params.dart';
import '../models/timetable_params.dart';

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

Day startDayTimeTable(TimetableParams params) {
  Day day;

  if (params.day == "Sunday") {
    day = Day.sunday;
  } else if (params.day == "Monday") {
    day = Day.monday;
  } else if (params.day == "Tuesday") {
    day = Day.tuesday;
  } else if (params.day == "Wednesday") {
    day = Day.wednesday;
  } else if (params.day == "Thursday") {
    day = Day.thursday;
  } else if (params.day == "Friday") {
    day = Day.friday;
  } else {
    day = Day.saturday;
  }

  return day;
}

TimeOfDay plusMinutes(TimeOfDay time, int minutesAdded) {
  int totalMinutes = (time.hour * 60) + time.minute;
  totalMinutes = totalMinutes - minutesAdded;

  int hours = (totalMinutes / 60).floor();
  int minutes = totalMinutes % 60;

  return TimeOfDay(hour: hours, minute: minutes);
}

Time startTimeTimetable(TimeOfDay timeOfDay) => Time(
      timeOfDay.hour,
      timeOfDay.minute,
    );

//FocusMode
DateTime endTimeFocusMode(FocusModeParams params) => DateTime(
      params.endTime.hour,
      params.endTime.minute,
    );

DateTime startTimeFocusMode(FocusModeParams params) => DateTime(
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

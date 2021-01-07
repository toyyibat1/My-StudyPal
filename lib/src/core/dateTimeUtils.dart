
import 'package:my_study_pal/src/models/timetable_params.dart';
import '../models/task_params.dart';


  DateTime date = DateTime.now();

  DateTime startDateTimeTask(date, TaskParams params) {
    return DateTime(params.date.year, params.date.month,
      params.date.day, params.startTime.hour, params.startTime.minute);
  }

  DateTime endDateTimeTask(date, TaskParams params){
      return DateTime(params.date.year, params.date.month,
        params.date.day, params.endTime.hour, params.endTime.minute); 
  }

  DateTime endDateTimeTable(date, TimetableParams params) {
    return DateTime(date.year, date.month, date.day,
      params.endTime.hour, params.endTime.minute);
  }

  DateTime startdateTimeTable(date, TimetableParams params) {
    return DateTime(date.year, date.month, date.day,
      params.startTime.hour, params.startTime.minute);
  }


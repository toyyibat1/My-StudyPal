
import 'package:my_study_pal/src/models/focus_mode_params.dart';
import 'package:my_study_pal/src/models/timetable_params.dart';
import '../models/task_params.dart';


  DateTime date = DateTime.now();

  DateTime startTimeTask(date, TaskParams params) => DateTime(params.date.year, params.date.month,
      params.date.day, params.startTime.hour, params.startTime.minute);
  

  DateTime endTimeTask(date, TaskParams params)=> DateTime(params.date.year, params.date.month,
        params.date.day, params.endTime.hour, params.endTime.minute); 
  

  DateTime endTimeTable(date, TimetableParams params) => DateTime(date.year, date.month, date.day,
      params.endTime.hour, params.endTime.minute);


  DateTime startTimeTable(date, TimetableParams params) => DateTime(date.year, date.month, date.day,
      params.startTime.hour, params.startTime.minute);
  
  DateTime endTimeFocusMode(FocusModeParams params) => DateTime(params.endTime.hour, params.endTime.minute);

  DateTime startTimeFocusMode(FocusModeParams params) => DateTime(params.startTime.hour, params.startTime.minute);


import 'package:my_study_pal/src/models/study_goal.dart';

import '../../models/app_user.dart';
import '../../models/school_schedule.dart';
import '../../models/school_schedule_params.dart';
import '../../models/study_goal_params.dart';
import '../../models/task.dart';
import '../../models/task_params.dart';
import '../../models/timetable.dart';
import '../../models/timetable_params.dart';

abstract class DatabaseService {
  Future<AppUser> getUserWithId(String userId);

  Future<void> createUserWithId(String userId,
      {String emailAddress, String firstName, String lastName});

  Future<void> updateUserWithId(
    String userId, {
    String firstName,
    String lastName,
    String institution,
    String course,
  });

  // task
  Future<Task> createTask(TaskParams params);

  Future<void> updateTask(String timetableId, TaskParams params);

  Future<void> deleteTask(String taskId);

  Future<void> changeTaskStatus(String taskId, bool status);

  Future<List<Task>> getAllTasks();

  Future<List<Task>> getPendingTasks();

  Future<List<Task>> getCompletedTasks();

  // timetable
  Future<Timetable> createTimetable(TimetableParams params);

  Future<void> updateTimetable(String timetableId, TimetableParams params);

  Future<void> deleteTimetable(String timetableId);

  Future<List<Timetable>> getAllTimetables();

  // Schedules
  Future<SchoolSchedule> createSchedule(SchoolScheduleParams params);

  Future<void> updateSchedule(String scheduleId, SchoolScheduleParams params);

  Future<void> deleteSchedule(String scheduleId);

  Future<List<SchoolSchedule>> getAllSchedules();

  //Study Goals
  Future<StudyGoal> createStudyGoal(StudyGoalParams params);

  Future<void> updateStudyGoal(String scheduleId, StudyGoalParams params);

  Future<void> deleteStudyGoal(String scheduleId);

  Future<List<StudyGoal>> getAllStudyGoals();
}

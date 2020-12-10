import 'package:my_study_pal/src/models/timetable.dart';
import 'package:my_study_pal/src/models/timetable_params.dart';
import 'package:my_study_pal/src/views/screens/study_goals.dart';

import '../../models/app_user.dart';
import '../../models/task.dart';
import '../../models/task_params.dart';
import '../../models/study_goals.dart';
import '../../models/study_goals_params.dart';

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

  //studyGoals
  Future<StudyGoal> createStudyGoal(StudyGoalParams params);

   Future<void> changeStudyGoalStatus(String studyGoalId, bool status);

  Future<List<StudyGoal>> getAllStudyGoals();

  // Future<List<StudyGoal>> getPendingStudyGoals();

  // Future<List<StudyGoal>> getCompletedStudyGoals();
}

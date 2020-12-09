import 'package:my_study_pal/src/models/timetable.dart';
import 'package:my_study_pal/src/models/timetable_params.dart';

import '../../models/app_user.dart';
import '../../models/task.dart';
import '../../models/task_params.dart';

abstract class DatabaseService {
  Future<AppUser> getUserWithId(String userId);

  Future<void> createUserWithId(String userId,
      {String emailAddress, String firstName, String lastName});

  Future<void> updateUserWithId(String userId,
      {String emailAddress, String firstName, String phoneNumber});
//task
  Future<Task> createTask(TaskParams params);

  Future<void> changeTaskStatus(String taskId, bool status);

  Future<List<Task>> getAllTasks();

  Future<List<Task>> getPendingTasks();

  Future<List<Task>> getCompletedTasks();
//  timetable

  Future<Timetable> createTimetable(TimetableParams params);

  Future<List<Timetable>> getAllTimetables();
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/app_user.dart';
import '../../models/school_schedule.dart';
import '../../models/school_schedule_params.dart';
import '../../models/task.dart';
import '../../models/task_params.dart';
import '../../models/timetable.dart';
import '../../models/timetable_params.dart';
import 'database_service.dart';

class FirebaseFirestoreService implements DatabaseService {
  final userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<AppUser> getUserWithId(String userId) async {
    final snapshot = await userCollection.doc(userId).get();
    return AppUser.fromDocumentSnapshot(snapshot);
  }

  @override
  Future<void> createUserWithId(
    String userId, {
    String emailAddress,
    String firstName,
    String lastName,
    String institution,
    String course,
  }) async {
    return await userCollection.doc(userId).set({
      'emailAddress': emailAddress,
      'firstName': firstName,
      'lastName': lastName,
      'institution': institution,
      'course': course,
    });
  }

  @override
  Future<void> updateUserWithId(
    String userId, {
    String firstName,
    String lastName,
    String institution,
    String course,
  }) async {
    return await userCollection.doc(userId).update({
      'firstName': firstName,
      'lastName': lastName,
      'institution': institution,
      'course': course,
    });
  }

  // task
  @override
  Future<Task> createTask(TaskParams params) async {
    User user = FirebaseAuth.instance.currentUser;

    DateTime startTime = DateTime(params.date.year, params.date.month,
        params.date.day, params.startTime.hour, params.startTime.minute);
    DateTime endTime = DateTime(params.date.year, params.date.month,
        params.date.day, params.endTime.hour, params.endTime.minute);

    DocumentReference reference =
        await userCollection.doc(user.uid).collection('tasks').add({
      'name': params.name,
      'description': params.description,
      'date': params.date.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'completed': false,
      'timestamp': Timestamp.now(),
    });

    DocumentSnapshot snapshot = await reference.get();

    return Task.fromDocumentSnapshot(snapshot);
  }

  @override
  Future<void> updateTask(String taskId, TaskParams params) async {
    User user = FirebaseAuth.instance.currentUser;

    DateTime startTime = DateTime(params.date.year, params.date.month,
        params.date.day, params.startTime.hour, params.startTime.minute);
    DateTime endTime = DateTime(params.date.year, params.date.month,
        params.date.day, params.endTime.hour, params.endTime.minute);

    return await userCollection
        .doc(user.uid)
        .collection('tasks')
        .doc(taskId)
        .update({
      'name': params.name,
      'description': params.description,
      'date': params.date.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    });
  }

  @override
  Future<void> deleteTask(String taskId) async {
    User user = FirebaseAuth.instance.currentUser;

    await userCollection.doc(user.uid).collection('tasks').doc(taskId).delete();
  }

  @override
  Future<void> changeTaskStatus(String taskId, bool status) async {
    User user = FirebaseAuth.instance.currentUser;

    return await userCollection
        .doc(user.uid)
        .collection('tasks')
        .doc(taskId)
        .update(
      {
        'completed': status,
      },
    );
  }

  @override
  Future<List<Task>> getAllTasks() async {
    User user = FirebaseAuth.instance.currentUser;

    List<Task> cards = [];

    List<QueryDocumentSnapshot> snapshot =
        (await userCollection.doc(user.uid).collection("tasks").get()).docs;

    snapshot.forEach(
      (card) => cards.add(Task.fromDocumentSnapshot(card)),
    );

    return cards;
  }

  @override
  Future<List<Task>> getPendingTasks() async {
    User user = FirebaseAuth.instance.currentUser;

    List<Task> cards = [];

    List<QueryDocumentSnapshot> snapshot = (await userCollection
            .doc(user.uid)
            .collection("tasks")
            .where('completed', isEqualTo: false)
            .get())
        .docs;

    snapshot.forEach(
      (card) => cards.add(Task.fromDocumentSnapshot(card)),
    );

    return cards;
  }

  @override
  Future<List<Task>> getCompletedTasks() async {
    User user = FirebaseAuth.instance.currentUser;

    List<Task> tasks = [];

    List<QueryDocumentSnapshot> snapshot = (await userCollection
            .doc(user.uid)
            .collection("tasks")
            .where('completed', isEqualTo: true)
            .get())
        .docs;

    snapshot.forEach(
      (task) => tasks.add(Task.fromDocumentSnapshot(task)),
    );

    return tasks;
  }

  // timetable
  @override
  Future<Timetable> createTimetable(TimetableParams params) async {
    User user = FirebaseAuth.instance.currentUser;

    DateTime date = DateTime.now();
    DateTime startTime = DateTime(date.year, date.month, date.day,
        params.startTime.hour, params.startTime.minute);
    DateTime endTime = DateTime(date.year, date.month, date.day,
        params.endTime.hour, params.endTime.minute);
    DocumentReference reference =
        await userCollection.doc(user.uid).collection('timetable').add({
      'subject': params.subject,
      'day': params.day,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'timestamp': Timestamp.now(),
      'location': params.location,
    });

    DocumentSnapshot snapshot = await reference.get();

    return Timetable.fromDocumentSnapshot(snapshot);
  }

  @override
  Future<void> updateTimetable(
      String timetableId, TimetableParams params) async {
    User user = FirebaseAuth.instance.currentUser;

    DateTime date = DateTime.now();
    DateTime startTime = DateTime(date.year, date.month, date.day,
        params.startTime.hour, params.startTime.minute);
    DateTime endTime = DateTime(date.year, date.month, date.day,
        params.endTime.hour, params.endTime.minute);

    return await userCollection
        .doc(user.uid)
        .collection('timetable')
        .doc(timetableId)
        .update({
      'subject': params.subject,
      'day': params.day,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'location': params.location,
    });
  }

  @override
  Future<void> deleteTimetable(String timetableId) async {
    User user = FirebaseAuth.instance.currentUser;

    await userCollection
        .doc(user.uid)
        .collection('timetable')
        .doc(timetableId)
        .delete();
  }

  @override
  Future<List<Timetable>> getAllTimetables() async {
    User user = FirebaseAuth.instance.currentUser;

    List<Timetable> timetables = [];

    List<QueryDocumentSnapshot> snapshot =
        (await userCollection.doc(user.uid).collection("timetable").get()).docs;

    snapshot.forEach(
      (timetable) => timetables.add(Timetable.fromDocumentSnapshot(timetable)),
    );

    return timetables;
  }

  // Schedules
  @override
  Future<SchoolSchedule> createSchedule(SchoolScheduleParams params) async {
    User user = FirebaseAuth.instance.currentUser;

    DocumentReference reference =
        await userCollection.doc(user.uid).collection('schedule').add({
      'name': params.name,
      'endOfSemester': params.endOfSemester.toIso8601String(),
      'startOfSemester': params.startOfSemester.toIso8601String(),
      'timestamp': Timestamp.now(),
    });

    DocumentSnapshot snapshot = await reference.get();

    return SchoolSchedule.fromDocumentSnapshot(snapshot);
  }

  @override
  Future<void> updateSchedule(
      String scheduleId, SchoolScheduleParams params) async {
    User user = FirebaseAuth.instance.currentUser;

    return await userCollection
        .doc(user.uid)
        .collection('schedule')
        .doc(scheduleId)
        .update({
      'name': params.name,
      'endOfSemester': params.endOfSemester.toIso8601String(),
      'startOfSemester': params.startOfSemester.toIso8601String(),
    });
  }

  @override
  Future<void> deleteSchedule(String scheduleId) async {
    User user = FirebaseAuth.instance.currentUser;

    await userCollection
        .doc(user.uid)
        .collection('schedule')
        .doc(scheduleId)
        .delete();
  }

  @override
  Future<List<SchoolSchedule>> getAllSchedules() async {
    User user = FirebaseAuth.instance.currentUser;

    List<SchoolSchedule> schedules = [];

    List<QueryDocumentSnapshot> snapshot =
        (await userCollection.doc(user.uid).collection("schedule").get()).docs;

    snapshot.forEach(
      (schedule) =>
          schedules.add(SchoolSchedule.fromDocumentSnapshot(schedule)),
    );

    return schedules;
  }
}

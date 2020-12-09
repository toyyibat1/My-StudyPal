import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_study_pal/src/models/timetable.dart';
import 'package:my_study_pal/src/models/timetable_params.dart';
import 'package:my_study_pal/src/views/screens/study_goals.dart';

import '../../models/app_user.dart';
import '../../models/task.dart';
import '../../models/task_params.dart';
import '../../models/study_goals_params.dart';
import '../../models/study_goals.dart';
import '../../models/schedule.dart';
import '../../models/schedule_params.dart';
import 'database_service.dart';

class FirebaseFirestoreService implements DatabaseService {
  final userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<AppUser> getUserWithId(String userId) async {
    final snapshot = await userCollection.doc(userId).get();
    return AppUser.fromDocumentSnapshot(snapshot);
  }

  @override
  Future<void> createUserWithId(String userId,
      {String emailAddress,
      String firstName,
      String lastName,
      String institution,
      String course}) async {
    return await userCollection.doc(userId).set({
      'emailAddress': emailAddress,
      'firstName': firstName,
      'lastName': lastName,
      'institution': institution,
      'course': course,
    });
  }

  @override
  Future<void> updateUserWithId(String userId,
      {String emailAddress, String firstName, String phoneNumber}) async {
    return await userCollection.doc(userId).update({
      'emailAddress': emailAddress,
      'fullName': firstName,
      'phoneNumber': phoneNumber,
    });
  }

//  task
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

    List<Task> cards = [];

    List<QueryDocumentSnapshot> snapshot = (await userCollection
            .doc(user.uid)
            .collection("tasks")
            .where('completed', isEqualTo: true)
            .get())
        .docs;

    snapshot.forEach(
      (card) => cards.add(Task.fromDocumentSnapshot(card)),
    );

    return cards;
  }

//  timetable
  @override
  Future<Timetable> createTimetable(TimetableParams params) async {
    User user = FirebaseAuth.instance.currentUser;

    DateTime startTime =
        DateTime(params.startTime.hour, params.startTime.minute);
    DateTime endTime = DateTime(params.endTime.hour, params.endTime.minute);

    DocumentReference reference =
        await userCollection.doc(user.uid).collection('timetable').add({
      'subject': params.subject,
//      'notification': params.notification,
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
  Future<List<Timetable>> getAllTimetables() async {
    User user = FirebaseAuth.instance.currentUser;

    List<Timetable> cards = [];

    List<QueryDocumentSnapshot> snapshot =
        (await userCollection.doc(user.uid).collection("timetable").get()).docs;

    snapshot.forEach(
      (card) => cards.add(Timetable.fromDocumentSnapshot(card)),
    );

    return cards;
  }

  Future<StudyGoal> createStudyGoal(StudyGoalParams params) async {
    User user = FirebaseAuth.instance.currentUser;

    DocumentReference reference =
        await userCollection.doc(user.uid).collection('studyGoals').add({
      'studyGoalname': params.studyGoalname,
      'date': params.date.toIso8601String(),
      'completed': false,
      'timestamp': Timestamp.now(),
    });

    DocumentSnapshot snapshot = await reference.get();

    return StudyGoal.fromDocumentSnapshot(snapshot);
  }

  @override
  Future<void> changeStudyGoalStatus(String studygoalId, bool status) async {
    User user = FirebaseAuth.instance.currentUser;

    return await userCollection
        .doc(user.uid)
        .collection('studyGoals')
        .doc(studygoalId)
        .update(
      {
        'completed': status,
      },
    );
  }

  @override
  Future<List<StudyGoal>> getAllStudyGoals() async {
    User user = FirebaseAuth.instance.currentUser;

    List<StudyGoal> cards = [];

    List<QueryDocumentSnapshot> snapshot =
        (await userCollection.doc(user.uid).collection("studyGoals").get()).docs;

    snapshot.forEach(
      (card) => cards.add(StudyGoal.fromDocumentSnapshot(card)),
    );

    return cards;
  }

 Future<Schedule> createSchedule(ScheduleParams params) async {
    User user = FirebaseAuth.instance.currentUser;

    DocumentReference reference =
        await userCollection.doc(user.uid).collection('schedules').add({
      'semesterName': params.semesterName,
      'startdate': params.startDate.toIso8601String(),
      'endDate': params.endDate.toIso8601String(),
      'completed': false,
      'timestamp': Timestamp.now(),
    });

    DocumentSnapshot snapshot = await reference.get();

    return Schedule.fromDocumentSnapshot(snapshot);
  }

  @override
  Future<void> changeScheduleStatus(String scheduleId, bool status) async {
    User user = FirebaseAuth.instance.currentUser;

    return await userCollection
        .doc(user.uid)
        .collection('schedules')
        .doc(scheduleId)
        .update(
      {
        'completed': status,
      },
    );
  }

  @override
  Future<List<Schedule>> getAllSchedules() async {
    User user = FirebaseAuth.instance.currentUser;

    List<Schedule> cards = [];

    List<QueryDocumentSnapshot> snapshot =
        (await userCollection.doc(user.uid).collection("schedules").get()).docs;

    snapshot.forEach(
      (card) => cards.add(Schedule.fromDocumentSnapshot(card)),
    );

    return cards;
  }

}

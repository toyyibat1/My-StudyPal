import 'package:cloud_firestore/cloud_firestore.dart';

class Badge {
  final String badgeTitle;
  final String desc;

  Badge({this.badgeTitle, this.desc});

  factory Badge.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
    Badge(
      badgeTitle: snapshot.data()['badgeTitle'],
      desc: snapshot.data()['desc']
    );
}
class TaskBadges {
  final String taskBadge;

  TaskBadges({this.taskBadge});

  factory TaskBadges.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      TaskBadges(
        taskBadge: snapshot.data()['taskBadge'],
      );
}

class CompletedTaskBadges {
  final String completedtask;

  CompletedTaskBadges({this.completedtask});

  factory CompletedTaskBadges.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      CompletedTaskBadges(
        completedtask: snapshot.data()['completedtask'],
      );
}

class TimetableBadges {
  final String timetable;

  TimetableBadges({this.timetable});

  factory TimetableBadges.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      TimetableBadges(
        timetable: snapshot.data()['timetable'],
      );
}

class StudyGoalBadges {
  final String studyGoal;

  StudyGoalBadges({this.studyGoal});

  factory StudyGoalBadges.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      StudyGoalBadges(
        studyGoal: snapshot.data()['studyGoal'],
      );
}

class SchoolScheduleBadges {
  final String schoolScheduleBadge;

  SchoolScheduleBadges({this.schoolScheduleBadge});

  factory SchoolScheduleBadges.fromDocumentSnapshot(
          DocumentSnapshot snapshot) =>
      SchoolScheduleBadges(
        schoolScheduleBadge: snapshot.data()['studyGoalBadge'],
      );
}

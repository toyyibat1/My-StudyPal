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
  final String timetableBadge;

  TimetableBadges({this.timetableBadge});

  factory TimetableBadges.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      TimetableBadges(
        timetableBadge: snapshot.data()['timetableBadge'],
      );
}

class StudyGoalBadges {
  final String studyGoalBadge;

  StudyGoalBadges({this.studyGoalBadge});

  factory StudyGoalBadges.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      StudyGoalBadges(
        studyGoalBadge: snapshot.data()['studyGoalBadge'],
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

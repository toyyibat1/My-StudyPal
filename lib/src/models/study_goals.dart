import 'package:cloud_firestore/cloud_firestore.dart';

class StudyGoal {
  final String id;
  final String studyGoalname;
  //final String studyGoalsToBeAchievied;
  final DateTime date;
  final Timestamp timestamp;
  final bool completed;

  StudyGoal({
    this.id,
    this.studyGoalname,
    //this.studyGoalsToBeAchievied,
    this.timestamp,
    this.date,
    this.completed = false,
  });

  factory StudyGoal.fromDocumentSnapshot(DocumentSnapshot snapshot) => StudyGoal(
        id: snapshot.id,
        studyGoalname: snapshot.data()['studyGoalname'],
     //   studyGoalsToBeAchievied: snapshot.data()['studyGoalsToBeAchievied'],
        date: DateTime.parse(snapshot.data()['date']),
        completed: snapshot.data()['completed'],
        timestamp: snapshot.data()['timestamp'],
      );
}

import 'package:cloud_firestore/cloud_firestore.dart';

class StudyGoal {
  final String id;
  final String goal;
  final DateTime date;
  final Timestamp timestamp;

  StudyGoal({
    this.id,
    this.goal,
    this.date,
    this.timestamp,
  });

  factory StudyGoal.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      StudyGoal(
        id: snapshot.id,
        goal: snapshot.data()['goal'],
        date: DateTime.parse(snapshot.data()['date']),
        timestamp: snapshot.data()['timestamp'],
      );
}

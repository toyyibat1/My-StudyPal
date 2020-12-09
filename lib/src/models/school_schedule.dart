import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolSchedule {
  final String id;
  final String name;
  final DateTime startOfSemester;
  final DateTime endOfSemester;
  final Timestamp timestamp;

  SchoolSchedule({
    this.id,
    this.name,
    this.startOfSemester,
    this.endOfSemester,
    this.timestamp,
  });

  factory SchoolSchedule.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      SchoolSchedule(
        id: snapshot.id,
        name: snapshot.data()['name'],
        startOfSemester: DateTime.parse(snapshot.data()['startOfSemester']),
        endOfSemester: DateTime.parse(snapshot.data()['endOfSemester']),
        timestamp: snapshot.data()['timestamp'],
      );
}

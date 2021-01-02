import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String id;
  final String semesterName;
  final DateTime startDate;
  final DateTime endDate;
  final Timestamp timestamp;
  final bool completed;

  Schedule({
    this.id,
    this.semesterName,
    this.startDate, 
    this.endDate, 
    this.timestamp,
    this.completed = false,
  });

  factory Schedule.fromDocumentSnapshot(DocumentSnapshot snapshot) => Schedule(
        id: snapshot.id,
        semesterName: snapshot.data()['semesterName'],
        startDate: DateTime.parse(snapshot.data()['startDate']),
        endDate: DateTime.parse(snapshot.data()['endDate']),
        completed: snapshot.data()['completed'],
        timestamp: snapshot.data()['timestamp'],
      );
}

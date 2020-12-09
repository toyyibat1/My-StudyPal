import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Timetable {
  final String id;
  final String day;
  final String subject;
  final String location;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Timestamp timestamp;

  Timetable({
    this.id,
    this.day,
    this.subject,
    this.location,
    this.startTime,
    this.endTime,
    this.timestamp,
  });

  factory Timetable.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      Timetable(
        id: snapshot.id,
        day: snapshot.data()['day'],
        subject: snapshot.data()['subject'],
        location: snapshot.data()['location'],
        startTime: TimeOfDay.fromDateTime(
            DateTime.parse(snapshot.data()['startTime'])),
        endTime:
            TimeOfDay.fromDateTime(DateTime.parse(snapshot.data()['endTime'])),
        timestamp: snapshot.data()['timestamp'],
      );
}

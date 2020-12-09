import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Timetable {
  final String id;
  final String day;
  final String subject;
  final DateTime location;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Timestamp timestamp;
  final bool completed;
  final String notification;

  Timetable(
      {this.id,
      this.day,
      this.subject,
      this.location,
      this.startTime,
      this.endTime,
      this.timestamp,
      this.completed = false,
      this.notification});

  factory Timetable.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      Timetable(
          id: snapshot.id,
          day: snapshot.data()['day'],
          subject: snapshot.data()['subject'],
          location: snapshot.data()['location'],
          startTime: TimeOfDay.fromDateTime(
              DateTime.parse(snapshot.data()['startTime'])),
          endTime: TimeOfDay.fromDateTime(
              DateTime.parse(snapshot.data()['endTime'])),
          completed: snapshot.data()['completed'],
          timestamp: snapshot.data()['timestamp'],
          notification: snapshot.data()['notification']);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Task {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Timestamp timestamp;
  final bool completed;

  Task({
    this.id,
    this.name,
    this.description,
    this.date,
    this.startTime,
    this.endTime,
    this.timestamp,
    this.completed = false,
  });

  factory Task.fromDocumentSnapshot(DocumentSnapshot snapshot) => Task(
        id: snapshot.id,
        name: snapshot.data()['name'],
        description: snapshot.data()['description'],
        date: DateTime.parse(snapshot.data()['date']),
        startTime: TimeOfDay.fromDateTime(
            DateTime.parse(snapshot.data()['startTime'])),
        endTime:
            TimeOfDay.fromDateTime(DateTime.parse(snapshot.data()['endTime'])),
        completed: snapshot.data()['completed'],
        timestamp: snapshot.data()['timestamp'],
      );
}

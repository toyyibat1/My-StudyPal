import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FocusMode {
  final String id;
  final bool focusModeToggle;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Timestamp timestamp;

  FocusMode({
    this.id,
    this.focusModeToggle,
    this.startTime,
    this.endTime,
    this.timestamp,
  });

  factory FocusMode.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      FocusMode(
        id: snapshot.id,
        focusModeToggle: snapshot.data()['toggle'],
        startTime: TimeOfDay.fromDateTime(
            DateTime.parse(snapshot.data()['startTime'])),
        endTime:
            TimeOfDay.fromDateTime(DateTime.parse(snapshot.data()['endTime'])),
        timestamp: snapshot.data()['timestamp'],
      );
}

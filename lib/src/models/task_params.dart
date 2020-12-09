import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TaskParams {
  final String name;
  final String description;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  TaskParams({
    @required this.name,
    @required this.description,
    @required this.date,
    @required this.startTime,
    @required this.endTime,
  });
}

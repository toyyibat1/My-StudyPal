import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TimetableParams {
  final String day;
  final String subject;
  final String location;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  TimetableParams({
    @required this.day,
    @required this.subject,
    @required this.location,
    @required this.startTime,
    @required this.endTime,
  });
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScheduleParams {
  final String semesterName;
  final DateTime startDate;
  final DateTime endDate;

  ScheduleParams({
    @required this.semesterName,
    @required this.startDate,
    @required this.endDate,
  });
}

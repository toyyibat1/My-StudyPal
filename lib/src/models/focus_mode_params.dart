import 'package:flutter/material.dart';

class FocusModeParams {
  final bool focusModeToggle;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  FocusModeParams({
    this.focusModeToggle,
    this.startTime,
    this.endTime,
  });
}

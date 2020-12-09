import 'package:flutter/material.dart';
import 'package:my_study_pal/src/controller/timetable_controller.dart';
import 'package:my_study_pal/src/models/timetable.dart';

import '../../core/constants.dart';

class TimetableTile extends StatelessWidget {
  final int index;
  final List<Timetable> timetables;
  final TimetableController controller;

  const TimetableTile({
    Key key,
    this.index,
    this.timetables,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 120,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              Container(
                width: 18,
                color: kPrimaryColor,
              ),
              Expanded(
                child: Container(
                  color: Color(0xFFF4F4F4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              timetables[index].subject,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(Icons.timer, size: 20),
                                SizedBox(width: 6),
                                Text(
                                  '${localizations.formatTimeOfDay(timetables[index].startTime)} - ${localizations.formatTimeOfDay(timetables[index].endTime)}',
                                  style: kLabelText,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

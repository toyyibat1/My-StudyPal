import 'package:flutter/material.dart';

import '../../controller/timetable_controller.dart';
import '../../core/constants.dart';
import '../../models/timetable.dart';

class TimetableTile extends StatelessWidget {
  final int index;
  final List<Timetable> timetables;
  final Timetable timetable;
  final TimetableController controller;

  const TimetableTile(
      {Key key, this.timetable, this.controller, this.timetables, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);

    return GestureDetector(
      onTap: () => controller.openTimetableInfoScreen(timetable),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          height: 100,
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
                                timetable.subject,
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
                                    '${localizations.formatTimeOfDay(timetable.startTime)} - ${localizations.formatTimeOfDay(timetable.endTime)}',
                                    style: kLabelText,
                                  ),
                                  SizedBox(width: 12),
                                  Icon(Icons.location_on_outlined, size: 20),
                                  SizedBox(width: 6),
                                  Text(
                                    timetable.location,
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
      ),
    );
  }
}

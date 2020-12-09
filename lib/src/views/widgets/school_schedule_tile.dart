import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../controller/school_schedule_controller.dart';
import '../../core/constants.dart';
import '../../models/school_schedule.dart';

class SchoolScheduleTile extends StatelessWidget {
  final SchoolSchedule schedule;
  final SchoolScheduleController controller;

  const SchoolScheduleTile({
    Key key,
    this.schedule,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.openScheduleInfoScreen(schedule),
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
                                schedule.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 20),
                                  SizedBox(width: 6),
                                  Text(
                                    '${DateFormat.yMMMd().format(schedule.startOfSemester)} - ${DateFormat.yMMMd().format(schedule.endOfSemester)}',
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

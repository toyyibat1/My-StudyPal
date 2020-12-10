import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../controller/study_goal_controller.dart';
import '../../core/constants.dart';
import '../../models/study_goal.dart';

class StudyGoalTile extends StatelessWidget {
  final StudyGoal studyGoal;
  final StudyGoalController controller;

  const StudyGoalTile({
    Key key,
    this.studyGoal,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.openStudyGoalInfoScreen(studyGoal),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color(0xFFF4F4F4),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        height: 70,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                child: Icon(Icons.gps_fixed, size: 36),
              ),
              Expanded(
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
                          Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: Text(
                              studyGoal.goal,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 20),
                              SizedBox(width: 6),
                              Text(
                                '${DateFormat.yMMMd().format(studyGoal.date)} ',
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
            ],
          ),
        ),
      ),
    );
  }
}

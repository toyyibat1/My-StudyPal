import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/views/widgets/study_goal_tile.dart';
import '../../controller/study_goal_controller.dart';
import '../widgets/school_schedule_tile.dart';

import '../../controller/school_schedule_controller.dart';
import '../../core/constants.dart';
import '../../core/notifier.dart';

class StudyGoalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudyGoalController>(
      init: StudyGoalController(),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              header,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                  child: controller.state == NotifierState.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : controller.studyGoals.isEmpty
                          ? Center(
                              child: SizedBox(
                                height: 180,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/goals.svg',
                                      color: Colors.grey.shade300,
                                    ),
                                    SizedBox(height: 8.0),
                                    Center(
                                      child: Text(
                                        'No Schedule',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kSmallVerticalSpacing,
                                Text(
                                  'My Study Goals',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                kTinyVerticalSpacing,
                                Column(
                                  children: controller.studyGoals
                                      .map((studyGoal) => StudyGoalTile(
                                            studyGoal: studyGoal,
                                            controller: controller,
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.add),
          onPressed: controller.navigateToCreateStudyGoal,
        ),
      ),
    );
  }

  Widget get header => Container(
        width: double.infinity,
        height: 40,
        color: kPrimaryColor2,
        child: Center(
          child: Text(
            'School Schedule',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controller/study_goal_controller.dart';
import '../../core/constants.dart';
import '../../core/notifier.dart';
import '../widgets/study_goal_tile.dart';

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
              header(context),
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
                                        'No Study Goals',
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

  Widget header(BuildContext context) => Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 16.0,
          right: MediaQuery.of(context).size.width * 0.44,
        ),
        height: 40,
        color: kPrimaryColor2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            Center(
              child: Text(
                'Study Goals',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
}

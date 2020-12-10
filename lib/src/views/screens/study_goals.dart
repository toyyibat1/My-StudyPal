import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/core/images.dart';

import '../../controller/study_goal_controller.dart';
import '../../core/constants.dart';
import '../../core/notifier.dart';
import '../widgets/study_goals_tile.dart';

class StudyGoalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudyGoalController>(
      init: StudyGoalController(),
      builder: (controller) => Scaffold(
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
                                      goal,
                                      color: Colors.grey.shade300,
                                    ),
                                    SizedBox(height: 8.0),
                                    Center(
                                      child: Text(
                                        'No Goals',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: controller.studyGoals.length,
                              itemBuilder: (context, index) {
                                return StudyGoalTile(
                                  index: index,
                                  studyGoals: controller.studyGoals,
                                  controller: controller,
                                );
                              },
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
      color: kPrimaryColor,
      child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            kTinyHorizontalSpacing,
            GestureDetector(
              onTap: Get.back,
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            kLargeHorizontalSpacing,
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
          ]));
}

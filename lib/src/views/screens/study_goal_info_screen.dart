import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/study_goal_info_controller.dart';
import '../../core/constants.dart';
import '../../core/notifier.dart';
import '../../models/study_goal.dart';
import '../widgets/app_button.dart';
import '../widgets/bottom_sheet_divider.dart';

class StudyGoalInfoScreen extends StatelessWidget {
  final StudyGoal studyGoal;
  final Function onGoBackCallback;

  const StudyGoalInfoScreen({
    Key key,
    @required this.studyGoal,
    @required this.onGoBackCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                kSmallVerticalSpacing,
                BottomSheetDivider(),
                kLargeVerticalSpacing,
                Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.gps_fixed, color: Colors.black),
                        title: Text(studyGoal.goal),
                      ),
                      ListTile(
                        leading:
                            Icon(Icons.calendar_today, color: Colors.black),
                        title: Text(DateFormat.yMMMd().format(studyGoal.date)),
                      ),
                    ],
                  ),
                ),
                GetBuilder<StudyGoalInfoController>(
                  init: StudyGoalInfoController(onGoBackCallback, studyGoal),
                  builder: (controller) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            label: 'Delete',
                            color: kPrimaryColor,
                            isLoading:
                                controller.state == NotifierState.isLoading,
                            textColor: Colors.white,
                            onPressed: () =>
                                controller.state == NotifierState.isLoading
                                    ? null
                                    : controller.deleteStudyGoal(studyGoal.id),
                          ),
                        ),
                        kMediumHorizontalSpacing,
                        Expanded(
                          child: AppButton(
                            label: 'Edit',
                            onPressed: () =>
                                controller.navigateToEditStudyGoal(studyGoal),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

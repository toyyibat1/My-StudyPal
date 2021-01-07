import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_study_pal/src/controller/school_schedule_info_controller.dart';

import '../../core/constants.dart';
import '../../core/notifier.dart';
import '../../models/school_schedule.dart';
import '../widgets/app_button.dart';
import '../widgets/bottom_sheet_divider.dart';

class SchoolScheduleInfoScreen extends StatelessWidget {
  final SchoolSchedule schedule;
  final Function onGoBackCallback;

  const SchoolScheduleInfoScreen({
    Key key,
    @required this.schedule,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    schedule.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                kLargeVerticalSpacing,
                Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.3),
                  child: Column(
                    children: [
                      ListTile(
                        leading:
                            Icon(Icons.calendar_today, color: Colors.black),
                        title: Text(
                            'Starts on ${DateFormat.yMMMd().format(schedule.startOfSemester)}'),
                      ),
                      ListTile(
                        leading:
                            Icon(Icons.calendar_today, color: Colors.black),
                        title: Text(
                            'Ends on ${DateFormat.yMMMd().format(schedule.endOfSemester)}'),
                      ),
                    ],
                  ),
                ),
                GetBuilder<SchoolScheduleInfoController>(
                  init: SchoolScheduleInfoController(onGoBackCallback),
                  builder: (controller) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            padding: 0,
                            label: 'Delete',
                            color: kPrimaryColor,
                            isLoading:
                                controller.state == NotifierState.isLoading,
                            textColor: Colors.white,
                            onPressed: () =>
                                controller.state == NotifierState.isLoading
                                    ? null
                                    : controller.deleteSchedule(schedule.id),
                          ),
                        ),
                        kMediumHorizontalSpacing,
                        Expanded(
                          child: AppButton(
                            padding: 0,
                            label: 'Edit',
                            onPressed: () => controller
                                .navigateToEditSchoolSchedule(schedule),
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

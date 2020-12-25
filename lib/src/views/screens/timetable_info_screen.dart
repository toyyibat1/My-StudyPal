import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/timetable_info_controller.dart';
import '../../core/constants.dart';
import '../../core/notifier.dart';
import '../../models/timetable.dart';
import '../widgets/app_button.dart';
import '../widgets/bottom_sheet_divider.dart';

class TimetableInfoScreen extends StatelessWidget {
  final Timetable timetable;
  final Function onGoBackCallback;

  const TimetableInfoScreen({
    Key key,
    @required this.timetable,
    @required this.onGoBackCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);

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
              mainAxisSize: MainAxisSize.min,
              children: [
                kSmallVerticalSpacing,
                BottomSheetDivider(),
                kLargeVerticalSpacing,
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            timetable.subject,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        kLargeVerticalSpacing,
                        ListTile(
                          leading:
                              Icon(Icons.calendar_today, color: Colors.black),
                          title: Text(timetable.day),
                        ),
                        ListTile(
                          leading: Icon(Icons.timer, color: Colors.black),
                          title: Text(
                              '${localizations.formatTimeOfDay(timetable.startTime)} - ${localizations.formatTimeOfDay(timetable.endTime)}'),
                        ),
                        ListTile(
                          leading: Icon(Icons.location_on, color: Colors.black),
                          title: Text(timetable.location),
                        ),
                      ],
                    ),
                  ),
                ),
//          Spacer(),
                GetBuilder<TimetableInfoController>(
                  init: TimetableInfoController(onGoBackCallback),
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
                                    : controller.deleteTimetable(timetable.id),
                          ),
                        ),
                        kMediumHorizontalSpacing,
                        Expanded(
                          child: AppButton(
                            padding: 0,
                            label: 'Edit',
                            onPressed: () =>
                                controller.navigateToEditTimetable(timetable),
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

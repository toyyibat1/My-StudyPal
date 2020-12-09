import 'package:flutter/material.dart';

import '../../controller/timetable_controller.dart';
import '../../core/constants.dart';
import '../../models/timetable.dart';

class TimetableTile extends StatelessWidget {
  final Timetable timetable;
  final TimetableController controller;

  const TimetableTile({
    Key key,
    this.timetable,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    Widget _showBottomSheet() {
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
          ),
          builder: (builder) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    timetables[index].subject,
                    style: kHeadingTextStyle,
                  ),
                  kMediumVerticalSpacing,
                  AppTextField(
                    text: '',
                    hintText: '${timetables[index].day}',
//                  validator: ValidationMixin().validateNotEmpty(),
//                  controller: controller.endTimeController,
                    enabled: false,
                    prefixIcon: Icon(
                      Icons.check_circle,
                      color: kPrimaryColor,
                    ),
                  ),
                  kMediumVerticalSpacing,
                  AppTextField(
                    text: "",
                    hintText:
                        '${localizations.formatTimeOfDay(timetables[index].startTime)} - ${localizations.formatTimeOfDay(timetables[index].endTime)}',
//                  validator: ValidationMixin().validateNotEmpty(),
//                  controller: controller.endTimeController,
                    enabled: false,
                    prefixIcon: Icon(
                      Icons.history,
                      color: kPrimaryColor,
                    ),
                  ),
                  kSmallVerticalSpacing,
                  AppTextField(
                    text: '',
                    hintText: '${timetables[index].location}',
//                  validator: ValidationMixin().validateNotEmpty(),
//                  controller: controller.endTimeController,
                    enabled: false,
                    prefixIcon: Icon(
                      Icons.check_circle,
                      color: kPrimaryColor,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          onPressed: () {},
                          textColor: Colors.white,
                          label: 'Delete',
                          color: kPrimaryColor,
                        ),
                      ),
                      kMediumHorizontalSpacing,
                      Expanded(
                        child: AppButton(
                          onPressed: () {},
                          textColor: Colors.white,
                          label: 'Edit',
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
    }

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

import 'package:flutter/material.dart';
import 'package:my_study_pal/src/controller/timetable_controller.dart';
import 'package:my_study_pal/src/models/timetable.dart';
import 'package:my_study_pal/src/views/widgets/app_button.dart';
import 'package:my_study_pal/src/views/widgets/app_textfield.dart';

import '../../core/constants.dart';

class TimetableTile extends StatelessWidget {
  final int index;
  final List<Timetable> timetables;
  final TimetableController controller;

  const TimetableTile({
    Key key,
    this.index,
    this.timetables,
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 120,
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
                        GestureDetector(
                          onTap: () => _showBottomSheet(),
//                              Get.bottomSheet(_showBottomSheet(),
//                              shape: BeveledRectangleBorder(
//                                borderRadius: BorderRadius.only(
//                                    topLeft: Radius.circular(40.0),
//                                    topRight: Radius.circular(40.0)),
//
//                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                timetables[index].subject,
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
                                    '${localizations.formatTimeOfDay(timetables[index].startTime)} - ${localizations.formatTimeOfDay(timetables[index].endTime)}',
                                    style: kLabelText,
                                  ),
                                ],
                              ),
                            ],
                          ),
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
    );
  }
}

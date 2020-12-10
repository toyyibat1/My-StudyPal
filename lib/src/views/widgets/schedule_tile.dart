import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/controller/schedule_controller.dart';
import 'package:my_study_pal/src/models/app_user.dart';
import 'package:my_study_pal/src/views/widgets/app_button.dart';
import 'package:my_study_pal/src/views/widgets/app_textfield.dart';

import '../../core/constants.dart';
import '../../models/schedule.dart';

class ScheduleTile extends StatelessWidget {
  final AppUser user;
  final int index;
  final List<Schedule> schedules;
  final ScheduleController controller;

  const ScheduleTile({
    Key key,
    this.index,
    this.schedules,
    this.controller,
    this.user,
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
                    schedules[index].semesterName,
                    style: kHeadingTextStyle,
                  ),
                  kMediumVerticalSpacing,
                  AppTextField(
                    text: "",
                    hintText:
                        '${localizations.formatFullDate(schedules[index].startDate)}',
                    enabled: false,
                    prefixIcon: Icon(
                      Icons.history,
                      color: kPrimaryColor,
                    ),
                  ),
                  kSmallVerticalSpacing,
                  AppTextField(
                    text: '',
                    hintText: '${schedules[index].completed}',
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

    return GetBuilder<ScheduleController>(
      init: ScheduleController(),
      builder: (controller) => Padding(
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  schedules[index].semesterName,
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
                                      '${localizations.formatFullDate(schedules[index].startDate)} - ${localizations.formatFullDate(schedules[index].endDate)}',
                                      style: kLabelText,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => controller.changeScheduleStatus(
                                schedules[index].id, !schedules[index].completed),
                            child: schedules[index].completed
                                ? Icon(
                                    Icons.check_circle,
                                    color: kPrimaryColor,
                                  )
                                : Icon(
                                    Icons.panorama_fish_eye,
                                    color: kPrimaryColor,
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
      ),
    );
  }
}

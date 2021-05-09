import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/core/notifier.dart';

import '../../controller/create_timetable_controller.dart';
import '../../core/constants.dart';
import '../widgets/app_button.dart';
import '../widgets/app_dropdown.dart';
import '../widgets/app_textfield.dart';
import '../widgets/transparent_statusbar.dart';

class CreateTimetableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TransparentStatusbar(
      child: GetBuilder<CreateTimetableController>(
        init: CreateTimetableController(),
        builder: (controller) => Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            leading: GestureDetector(
              onTap: controller.goBack,
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            title: Text(
              'Create New Timetable',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            elevation: 0,
          ),
          body: SafeArea(
            child: Column(
              children: [
//                header(context, controller),
                form(context, controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context, CreateTimetableController controller) =>
      Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 16.0,
          right: MediaQuery.of(context).size.width * 0.25,
        ),
        height: 40,
        color: kPrimaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: controller.goBack,
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            Center(
              child: Text(
                'Create New Timetable',
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

  Widget form(BuildContext context, CreateTimetableController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                kMediumVerticalSpacing,
                AppDropdown(
                  items: [
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday',
                  ],
                  text: 'Day of the week',
                  onChanged: (val) =>
                      controller.timetableDayController.text = val,
                  value: 'Monday',
                  validator: (val) =>
                      val == 'Select Day' ? 'Please select a valid day' : null,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'Subject',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.timetableSubjectController,
                  validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  maxLines: 3,
                  text: 'Location',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.timetableLocationController,
                  validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.selectStartTime(context);
                        },
                        child: AppTextField(
                          text: 'Start Time',
                          hintText: 'Select Time',
                          validator: controller.validateNotEmpty,
                          controller: controller.startTimeController,
                          enabled: false,
                          prefixIcon: Icon(Icons.history),
                        ),
                      ),
                    ),
                    kMediumHorizontalSpacing,
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.selectEndTime(context);
                        },
                        child: AppTextField(
                          text: 'End Time',
                          hintText: 'Set Time',
                          validator: controller.validateNotEmpty,
                          controller: controller.endTimeController,
                          enabled: false,
                          prefixIcon: Icon(Icons.history),
                        ),
                      ),
                    ),
                  ],
                ),
                kSmallVerticalSpacing,
                Row(
                  children: [
                    Radio(
                      value: 0,
                      groupValue: controller.radioValue,
                      onChanged: (int rVal) {
                        controller.changeRadio(rVal);
                      },
                    ),
                    Text('15 minutes to start time'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: controller.radioValue,
                      onChanged: (int rVal) {
                        controller.changeRadio(rVal);
                      },
                    ),
                    Text('30 minutes to start time'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: controller.radioValue,
                      onChanged: (int rVal) {
                        controller.changeRadio(rVal);
                      },
                    ),
                    Text('60 minutes to start time'),
                  ],
                ),
                kLargeVerticalSpacing,
                AppButton(
                  label: 'Create Timetable',
                  color: kPrimaryColor,
                  isLoading: controller.state == NotifierState.isLoading,
                  textColor: Colors.white,
                  onPressed: controller.state == NotifierState.isLoading
                      ? null
                      : controller.createTimetable,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

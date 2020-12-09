import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/edit_school_schedule_controller.dart';
import '../../core/constants.dart';
import '../../core/notifier.dart';
import '../../models/school_schedule.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';
import '../widgets/transparent_statusbar.dart';

class EditSchoolScheduleScreen extends StatelessWidget {
  final SchoolSchedule schedule;
  EditSchoolScheduleScreen({Key key, @required this.schedule})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransparentStatusbar(
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<EditSchoolScheduleController>(
            init: EditSchoolScheduleController(schedule),
            builder: (controller) => Column(
              children: [
                header(context, controller),
                form(context, controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header(
          BuildContext context, EditSchoolScheduleController controller) =>
      Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 16.0,
          right: MediaQuery.of(context).size.width * 0.33,
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
                'Edit Timetable',
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

  Widget form(BuildContext context, EditSchoolScheduleController controller) {
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
                AppTextField(
                  text: 'Name of Semester',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.nameController,
                  validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                GestureDetector(
                  onTap: () {
                    controller.selectStartDate(context);
                  },
                  child: AppTextField(
                    text: 'Start of Semester',
                    hintText: 'Select Date',
                    validator: controller.validateNotEmpty,
                    controller: controller.startOfSemesterController,
                    enabled: false,
                    prefixIcon: Icon(Icons.history),
                  ),
                ),
                kMediumVerticalSpacing,
                GestureDetector(
                  onTap: () {
                    controller.selectEndDate(context);
                  },
                  child: AppTextField(
                    text: 'End of Semester',
                    hintText: 'Select Date',
                    validator: controller.validateNotEmpty,
                    controller: controller.endOfSemesterController,
                    enabled: false,
                    prefixIcon: Icon(Icons.history),
                  ),
                ),
                kLargeVerticalSpacing,
                AppButton(
                  label: 'Edit Schedule',
                  color: kPrimaryColor,
                  isLoading: controller.state == NotifierState.isLoading,
                  textColor: Colors.white,
                  onPressed: () => controller.state == NotifierState.isLoading
                      ? null
                      : controller.updateSchedule(schedule.id),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

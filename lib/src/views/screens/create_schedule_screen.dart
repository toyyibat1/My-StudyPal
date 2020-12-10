import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/core/notifier.dart';
import 'package:my_study_pal/src/models/app_user.dart';

import '../../controller/create_schedule_controller.dart';
import '../../core/constants.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';
import '../widgets/transparent_statusbar.dart';

class CreateScheduleScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TransparentStatusbar(
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<CreateScheduleController>(
            init: CreateScheduleController(),
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

  Widget header(BuildContext context, CreateScheduleController controller) =>
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
                'School Schedule',
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

  Widget form(BuildContext context, CreateScheduleController controller) {
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
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.scheduleNameController,
                  validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                GestureDetector(
                  onTap: () {
                    controller.selectStartDate(context);
                  },
                child: AppTextField(
                  text: 'Start of Semester',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.startDateController,
                  validator: controller.validateNotEmpty,
                  enabled: false,
                  hintText: 'Select Date',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                ),
                kLargeVerticalSpacing,
                GestureDetector(
                  onTap: () {
                    controller.selectEndDate(context);
                  },
                child: AppTextField(
                  text: 'End of Semester',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.endDateController,
                  validator: controller.validateNotEmpty,
                  enabled: false,
                  hintText: 'Select Date',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                ),
                kLargeVerticalSpacing,
                AppButton(
                  label: 'Create Schedule',
                  color: kPrimaryColor,
                  isLoading: controller.state == NotifierState.isLoading,
                  textColor: Colors.white,
                  onPressed: controller.state == NotifierState.isLoading
                      ? null
                      : controller.createSchedule,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
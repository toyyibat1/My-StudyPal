import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/create_school_schedule_controller.dart';
import '../../core/constants.dart';
import '../../core/notifier.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';
import '../widgets/transparent_statusbar.dart';

class CreateSchoolScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TransparentStatusbar(
      child: GetBuilder<CreateSchoolScheduleController>(
        init: CreateSchoolScheduleController(),
        builder: (controller) => (Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            leading: GestureDetector(
              onTap: controller.goBack,
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            title: Text(
              'Create New School Schedule',
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
        )),
      ),
    );
  }

  Widget header(
          BuildContext context, CreateSchoolScheduleController controller) =>
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
                'Create New Schedule',
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

  Widget form(BuildContext context, CreateSchoolScheduleController controller) {
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

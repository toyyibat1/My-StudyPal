import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/controller/focus_mode_controller.dart';
import 'package:my_study_pal/src/core/notifier.dart';
import 'package:my_study_pal/src/views/widgets/app_button.dart';
import 'package:my_study_pal/src/views/widgets/app_textfield.dart';

import '../../core/constants.dart';

class FocusModeScreen extends StatefulWidget {
  @override
  _FocusModeScreenState createState() => _FocusModeScreenState();
}

class _FocusModeScreenState extends State<FocusModeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<FocusModeController>(
            init: FocusModeController(),
            builder: (controller) => Column(
                  children: [
                    header(context),
                    kExtraLargeVerticalSpacing,
                    form(context, controller)
                  ],
                )),
      ),
    );
  }

  Widget header(BuildContext context) => Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 16.0,
          right: MediaQuery.of(context).size.width * 0.44,
        ),
        height: 40,
        color: kPrimaryColor2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            Center(
              child: Text(
                'Focus Mode',
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

  Widget form(BuildContext context, FocusModeController controller) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Focus Mode',
                          softWrap: true,
                          style: kHeadingTextStyle,
                        ),
                        Text(
                          'By puting on the focus mode, you won\'t \nrecieve any notification',
                          softWrap: true,
                        )
                      ],
                    ),
                    Switch(
                      activeColor: kPrimaryColor2,
                      value: controller.focusModeToggle,
                      onChanged: (value) {
                        controller.onChange();
                      },
                    ),
                  ],
                ),
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
                kLargeVerticalSpacing,
                AppButton(
                    label: 'Save',
                    color: kPrimaryColor,
                    isLoading: controller.state == NotifierState.isLoading,
                    textColor: Colors.white,
                    onPressed: controller.state == NotifierState.isLoading
                        ? null
                        : () => controller.createFocusMode()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/core/notifier.dart';
import 'package:my_study_pal/src/models/app_user.dart';

import '../../controller/create_study_goals_controller.dart';
import '../../core/constants.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';
import '../widgets/transparent_statusbar.dart';

class CreateStudyGoalScreen extends StatelessWidget {
  final AppUser user;
  CreateStudyGoalScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransparentStatusbar(
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<CreateStudyGoalController>(
            init: CreateStudyGoalController(),
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

  Widget header(BuildContext context, CreateStudyGoalController controller) =>
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
                'Study Goals',
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

  Widget form(BuildContext context, CreateStudyGoalController controller) {
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
                  text: 'What are your study goals',
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.studyGoalNameController,
                  validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                GestureDetector(
                  onTap: () {
                    controller.selectDate(context);
                  },
                child: AppTextField(
                  text: 'When did you want your goal to be achieved?',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.dateController,
                  validator: controller.validateNotEmpty,
                  enabled: false,
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                ),
                kLargeVerticalSpacing,
                AppButton(
                  label: 'Create Study Goals',
                  color: kPrimaryColor,
                  isLoading: controller.state == NotifierState.isLoading,
                  textColor: Colors.white,
                  onPressed: controller.state == NotifierState.isLoading
                      ? null
                      : controller.createStudyGoal,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


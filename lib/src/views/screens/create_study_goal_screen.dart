import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/create_study_goal_controller.dart';
import '../../core/constants.dart';
import '../../core/notifier.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';
import '../widgets/transparent_statusbar.dart';

class CreateStudyGoalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TransparentStatusbar(
      child: GetBuilder<CreateStudyGoalController>(
        init: CreateStudyGoalController(),
        builder: (controller) => (Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            leading: GestureDetector(
              onTap: controller.goBack,
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            title: Text(
              'Create New Study Goal',
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

  Widget header(BuildContext context, CreateStudyGoalController controller) =>
      Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 16.0,
          right: MediaQuery.of(context).size.width * 0.22,
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
                'Create New Study Goal',
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
                  maxLines: 3,
                  text: 'What are your study goals',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.goalController,
                  validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                GestureDetector(
                  onTap: () {
                    controller.selectDate(context);
                  },
                  child: AppTextField(
                    text: 'When do you want your goal to be achieved',
                    hintText: 'Select Date',
                    validator: controller.validateNotEmpty,
                    controller: controller.dateController,
                    enabled: false,
                    prefixIcon: Icon(Icons.history),
                  ),
                ),
                kLargeVerticalSpacing,
                AppButton(
                  label: 'Create Study Goal',
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

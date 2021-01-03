import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/edit_task_controller.dart';
import '../../core/constants.dart';
import '../../core/notifier.dart';
import '../../models/task.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';
import '../widgets/transparent_statusbar.dart';

class EditTaskScreen extends StatelessWidget {
  final Task task;
  EditTaskScreen({Key key, @required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransparentStatusbar(
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<EditTaskController>(
            init: EditTaskController(task)..formatTimes(context),
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

  Widget header(BuildContext context, EditTaskController controller) =>
      Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 16.0,
          right: MediaQuery.of(context).size.width * 0.40,
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
                'Edit Task',
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

  Widget form(BuildContext context, EditTaskController controller) {
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
                  text: 'Task Name',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.taskNameController,
                  validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  maxLines: 3,
                  text: 'Task Description',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.taskDescriptionController,
                  validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                GestureDetector(
                  onTap: () {
                    controller.selectDate(context);
                  },
                  child: AppTextField(
                    text: 'Date',
                    hintText: 'Select Date',
                    controller: controller.dateController,
                    validator: controller.validateNotEmpty,
                    enabled: false,
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
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
                kLargeVerticalSpacing,
                AppButton(
                  label: 'Update Task',
                  color: kPrimaryColor,
                  isLoading: controller.state == NotifierState.isLoading,
                  textColor: Colors.white,
                  onPressed: () => controller.state == NotifierState.isLoading
                      ? null
                      : controller.updateTask(task.id),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

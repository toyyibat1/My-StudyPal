import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/controller/task_controller.dart';
import 'package:my_study_pal/src/models/app_user.dart';
import 'package:my_study_pal/src/views/widgets/app_button.dart';
import 'package:my_study_pal/src/views/widgets/app_textfield.dart';

import '../../core/constants.dart';
import '../../models/task.dart';

class TaskTile extends StatelessWidget {
  final AppUser user;
  final int index;
  final List<Task> tasks;
  final TaskController controller;

  const TaskTile({
    Key key,
    this.index,
    this.tasks,
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
                    tasks[index].name,
                    style: kHeadingTextStyle,
                  ),
                  kMediumVerticalSpacing,
                  AppTextField(
                    text: "",
                    hintText:
                        '${localizations.formatTimeOfDay(tasks[index].endTime)}',
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
                    hintText: '${tasks[index].completed}',
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

    return GetBuilder<TaskController>(
      init: TaskController(),
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
                                  tasks[index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  tasks[index].description,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Icon(Icons.timer, size: 20),
                                    SizedBox(width: 6),
                                    Text(
                                      '${localizations.formatTimeOfDay(tasks[index].startTime)} - ${localizations.formatTimeOfDay(tasks[index].endTime)}',
                                      style: kLabelText,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => controller.changeTaskStatus(
                                tasks[index].id, !tasks[index].completed),
                            child: tasks[index].completed
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

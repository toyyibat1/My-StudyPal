import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/controller/dashboard_controller.dart';

import '../../controller/home_controller.dart';
import '../../core/constants.dart';
import '../../core/images.dart';
import '../../models/task.dart';
import '../widgets/task_list.dart';
import '../widgets/task_tag.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => SafeArea(
        child: Column(
          children: [
            header(controller),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GetBuilder<DashboardController>(
                    init: DashboardController(),
                    builder: (dashboardController) => Column(
                      children: [
                        kMediumVerticalSpacing,
                        taskSnapshot(dashboardController),
                        kMediumVerticalSpacing,
                        TaskList(
                          controller: dashboardController,
                          tagColor: kPrimaryColor,
                          title: 'Pending',
                          tasks: dashboardController.pendingTasks,
                        ),
                        kMediumVerticalSpacing,
                        TaskList(
                          controller: dashboardController,
                          tagColor: kPrimaryColor2,
                          title: 'Completed',
                          tasks: dashboardController.completedTasks,
                        ),
                        kMediumVerticalSpacing,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget header(HomeController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
              text: "Welcome,\n",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
              children: [
                TextSpan(
                  text:
                      '${controller.user.firstName} ${controller.user.lastName}',
                  style: TextStyle(
                    color: kBlackColor,
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              welcome,
              width: 60,
              height: 60,
            ),
          ),
        ],
      ),
    );
  }

  Widget taskSnapshot(DashboardController dashboardController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TaskTag(
            text: '${dashboardController.pendingTasks.length}',
            headText: 'Number of Pending Task',
            color: kPrimaryColor2,
          ),
        ),
        kSmallHorizontalSpacing,
        Expanded(
          child: TaskTag(
            text: '${dashboardController.completedTasks.length}',
            headText: 'Number of Completed Task',
            color: kPrimaryColor,
          ),
        ),
      ],
    );
  }
}

List<Task> pendingTasks = [
  Task(
    id: "1",
    name: "Reading about Ethics",
    description: 'I want to read about Ethics',
    date: DateTime.now(),
    startTime: TimeOfDay.now(),
    endTime: TimeOfDay.now(),
  ),
  Task(
    id: "2",
    name: "Reading about Ethics",
    description: 'I want to read about Ethics',
    date: DateTime.now(),
    startTime: TimeOfDay.now(),
    endTime: TimeOfDay.now(),
  ),
  Task(
    id: "3",
    name: "Reading about Ethics",
    description: 'I want to read about Ethics',
    date: DateTime.now(),
    startTime: TimeOfDay.now(),
    endTime: TimeOfDay.now(),
  ),
];

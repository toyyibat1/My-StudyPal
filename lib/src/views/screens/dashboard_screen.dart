import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/dashboard_controller.dart';
import '../../core/constants.dart';
import '../../core/notifier.dart';
import '../../models/task.dart';
import '../widgets/task_list.dart';
import '../widgets/task_tag.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController()..getAuthenticatedUser(),
      builder: (controller) => SafeArea(
        child: controller.state == NotifierState.isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  header(context, controller),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            kMediumVerticalSpacing,
                            taskSnapshot(controller),
                            kMediumVerticalSpacing,
                            TaskList(
                              controller: controller,
                              tagColor: kPrimaryColor,
                              title: 'Pending',
                              tasks: controller.pendingTasks,
                            ),
                            kMediumVerticalSpacing,
                            TaskList(
                              controller: controller,
                              tagColor: kPrimaryColor2,
                              title: 'Completed',
                              tasks: controller.completedTasks,
                            ),
                            kMediumVerticalSpacing,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget header(BuildContext context, DashboardController controller) {
    String firstName = controller.user.firstName ?? '';
    String lastName = controller.user.lastName ?? '';
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.78,
            child: Text.rich(
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
                    text: '$firstName $lastName',
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(8),
          //   child: Image.asset(
          //     welcome,
          //     width: 60,
          //     height: 60,
          //   ),
          // ),
          CircleAvatar(
            radius: 25,
            child: Text(
              controller.user.firstName[0],
              style: kHeadingTextStyle,
            ),
            backgroundColor: Color(0xFFE0E0E0),
          )
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

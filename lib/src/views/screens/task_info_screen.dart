import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/task_info_controller.dart';
import '../../core/constants.dart';
import '../../core/notifier.dart';
import '../../models/task.dart';
import '../widgets/app_button.dart';
import '../widgets/app_tile.dart';
import '../widgets/bottom_sheet_divider.dart';

class TaskInfoScreen extends StatelessWidget {
  final Task task;
  final Function onGoBackCallback;

  const TaskInfoScreen({
    Key key,
    @required this.task,
    @required this.onGoBackCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          kSmallVerticalSpacing,
          BottomSheetDivider(),
          kLargeVerticalSpacing,
          Text(
            task.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          kLargeVerticalSpacing,
          AppTile(
            leading:
                task.completed ? Icons.check_circle : Icons.panorama_fish_eye,
            title: task.completed ? 'Completed' : 'Not Completed',
          ),
          AppTile(title: task.description),
          Spacer(),
          GetBuilder<TaskInfoController>(
            init: TaskInfoController(onGoBackCallback),
            builder: (controller) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      padding: 0,
                      label: 'Delete',
                      color: kPrimaryColor,
                      isLoading: controller.state == NotifierState.isLoading,
                      textColor: Colors.white,
                      onPressed: () =>
                          controller.state == NotifierState.isLoading
                              ? null
                              : controller.deleteTask(task.id),
                    ),
                  ),
                  kMediumHorizontalSpacing,
                  Expanded(
                    child: AppButton(
                      padding: 0,
                      label: 'Edit',
                      onPressed: () => controller.navigateToEditTask(task),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

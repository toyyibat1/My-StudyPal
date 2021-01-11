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
    final localizations = MaterialLocalizations.of(context);

    return Wrap(
      children: [
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                kSmallVerticalSpacing,
                BottomSheetDivider(),
                kLargeVerticalSpacing,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    task.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                kLargeVerticalSpacing,
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.7),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AppTile(
                            leading: task.completed
                                ? Icons.check_circle
                                : Icons.panorama_fish_eye,
                            title:
                                task.completed ? 'Completed' : 'Not Completed',
                          ),
                          AppTile(title: task.description),
                          AppTile(
                              leading: Icons.timer,
                              title:
                                  '${localizations.formatTimeOfDay(task.startTime)} - ${localizations.formatTimeOfDay(task.endTime)}'),
                        ],
                      ),
                    ),
                  ),
                ),
                GetBuilder<TaskInfoController>(
                  init: TaskInfoController(onGoBackCallback, task),
                  builder: (controller) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            label: 'Delete',
                            color: kPrimaryColor,
                            isLoading:
                                controller.state == NotifierState.isLoading,
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
                            label: 'Edit',
                            onPressed: () =>
                                controller.navigateToEditTask(task),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

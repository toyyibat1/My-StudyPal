import 'package:flutter/material.dart';

import '../../controller/task_controller.dart';
import '../../core/constants.dart';
import '../../models/task.dart';

class TaskTile extends StatelessWidget {
  final int index;
  final List<Task> tasks;
  final TaskController controller;

  const TaskTile({
    Key key,
    this.index,
    this.tasks,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);

    return GestureDetector(
      onTap: () => controller.openTaskInfoScreen(tasks[index]),
      child: Padding(
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tasks[index].name,
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                tasks[index].description,
                                softWrap: true,
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
                                    '${localizations.formatTimeOfDay(tasks[index].startTime)} - ${localizations.formatTimeOfDay(tasks[index].startTime)}',
                                    style: kLabelText,
                                  ),
                                ],
                              ),
                            ],
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:my_study_pal/src/controller/dashboard_controller.dart';

import '../../core/constants.dart';
import '../../models/task.dart';

class TaskList extends StatelessWidget {
  final String title;
  final Color tagColor;
  final List<Task> tasks;
  final DashboardController controller;

  const TaskList({
    Key key,
    @required this.title,
    @required this.tasks,
    @required this.tagColor,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 8),
        tasks.isEmpty
            ? SizedBox(
                height: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/no_task.svg',
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: 8.0),
                    Center(
                      child: Text(
                        'No Task',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                constraints: BoxConstraints(maxHeight: 324),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: SizedBox(
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                color: tagColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat.E().format(tasks[index].date),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      DateFormat.d().format(tasks[index].date),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    kTinyVerticalSpacing,
                                    Text(
                                      DateFormat.y().format(tasks[index].date),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Color(0xFFF4F4F4),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.8,
                                              child: Text(
                                                tasks[index].name,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(height: 20),
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
                                        GestureDetector(
                                          onTap: () =>
                                              controller.changeTaskStatus(
                                                  tasks[index].id,
                                                  !tasks[index].completed),
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
                    );
                  },
                ),
              )
      ],
    );
  }
}

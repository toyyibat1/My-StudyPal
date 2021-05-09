import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/models/timetable.dart';

import '../../controller/timetable_controller.dart';
import '../../core/constants.dart';
import '../../core/notifier.dart';
import '../widgets/timetable_tile.dart';

class TimetableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimetableController>(
      init: TimetableController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'Timetable',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          )),
          backgroundColor: kPrimaryColor2,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
//              header,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                  child: controller.state == NotifierState.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : controller.timetables.isEmpty
                          ? Center(
                              child: SizedBox(
                                height: 180,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/timetable.svg',
                                      color: Colors.grey.shade300,
                                    ),
                                    SizedBox(height: 8.0),
                                    Center(
                                      child: Text(
                                        'No Timetable',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : timetable(controller),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Click me to create a timetable",
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.add),
          onPressed: controller.navigateToCreateTimetable,
        ),
      ),
    );
  }

  Widget get header => Container(
        width: double.infinity,
        height: 40,
        color: kPrimaryColor2,
        child: Center(
          child: Text(
            'Timetable',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      );

  List<Timetable> dayTimetable(String day, List<Timetable> subjects) {
    List<Timetable> dayTimetable = [];

    subjects.forEach((timetable) {
      if (timetable.day == day) {
        dayTimetable.add(timetable);
      }
    });

    return dayTimetable;
  }

  Widget timetable(TimetableController controller) {
    final monday = dayTimetable('Monday', controller.timetables);
    final tuesday = dayTimetable('Tuesday', controller.timetables);
    final wednesday = dayTimetable('Wednesday', controller.timetables);
    final thursday = dayTimetable('Thursday', controller.timetables);
    final friday = dayTimetable('Friday', controller.timetables);
    final saturday = dayTimetable('Saturday', controller.timetables);
    final sunday = dayTimetable('Sunday', controller.timetables);

    return SingleChildScrollView(
      child: Column(
        children: [
          monday.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kSmallVerticalSpacing,
                    Text(
                      'Monday',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      children: monday
                          .map(
                            (timetable) => TimetableTile(
                              timetable: timetable,
                              controller: controller,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                )
              : Container(),
          tuesday.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kSmallVerticalSpacing,
                    Text(
                      'Tuesday',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      children: tuesday
                          .map(
                            (timetable) => TimetableTile(
                              timetable: timetable,
                              controller: controller,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                )
              : Container(),
          wednesday.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kSmallVerticalSpacing,
                    Text(
                      'Wednesday',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      children: wednesday
                          .map(
                            (timetable) => TimetableTile(
                              timetable: timetable,
                              controller: controller,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                )
              : Container(),
          thursday.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kSmallVerticalSpacing,
                    Text(
                      'Thursday',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      children: thursday
                          .map(
                            (timetable) => TimetableTile(
                              timetable: timetable,
                              controller: controller,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                )
              : Container(),
          friday.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kSmallVerticalSpacing,
                    Text(
                      'Friday',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      children: friday
                          .map(
                            (timetable) => TimetableTile(
                              timetable: timetable,
                              controller: controller,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                )
              : Container(),
          saturday.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kSmallVerticalSpacing,
                    Text(
                      'Saturday',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      children: saturday
                          .map(
                            (timetable) => TimetableTile(
                              timetable: timetable,
                              controller: controller,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                )
              : Container(),
          sunday.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kSmallVerticalSpacing,
                    Text(
                      'Sunday',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(
                      children: sunday
                          .map(
                            (timetable) => TimetableTile(
                              timetable: timetable,
                              controller: controller,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

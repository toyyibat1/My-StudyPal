import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/views/widgets/school_schedule_tile.dart';

import '../../controller/school_schedule_controller.dart';
import '../../core/constants.dart';
import '../../core/notifier.dart';

class SchoolScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SchoolScheduleController>(
      init: SchoolScheduleController(),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              header(context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                  child: controller.state == NotifierState.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : controller.schedules.isEmpty
                          ? Center(
                              child: SizedBox(
                                height: 180,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/schedule.svg',
                                      color: Colors.grey.shade300,
                                    ),
                                    SizedBox(height: 8.0),
                                    Center(
                                      child: Text(
                                        'No Schedule',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Column(
                              children: controller.schedules
                                  .map(
                                    (schedule) => SchoolScheduleTile(
                                      schedule: schedule,
                                      controller: controller,
                                    ),
                                  )
                                  .toList(),
                            ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.add),
          onPressed: controller.navigateToCreateSchedule,
        ),
      ),
    );
  }

  Widget header(BuildContext context) => Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 16.0,
          right: MediaQuery.of(context).size.width * 0.33,
        ),
        height: 40,
        color: kPrimaryColor2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            Center(
              child: Text(
                'School Schedule',
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
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/core/images.dart';

import '../../controller/schedule_controller.dart';
import '../../core/constants.dart';
import '../../core/notifier.dart';
import '../widgets/schedule_tile.dart';

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduleController>(
      init: ScheduleController(),
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              header,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                  child: controller.state == NotifierState.isLoading
                      ? Center(child: Text('Loading'))
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
                                      goal,
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
                          : ListView.builder(
                              itemCount: controller.schedules.length,
                              itemBuilder: (context, index) {
                                return ScheduleTile(
                                  index: index,
                                  schedules: controller.schedules,
                                  controller: controller,
                                );
                              },
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

  Widget get header => Container(
      width: double.infinity,
      height: 40,
      color: kPrimaryColor,
      child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            kTinyHorizontalSpacing,
            GestureDetector(
              onTap: Get.back,
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            kLargeHorizontalSpacing,
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
          ]));
}

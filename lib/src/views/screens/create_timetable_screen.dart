import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/controller/create_timetable_controller.dart';
import 'package:my_study_pal/src/core/notifier.dart';
import 'package:my_study_pal/src/models/app_user.dart';

import '../../core/constants.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';
import '../widgets/transparent_statusbar.dart';

class CreateTimetableScreen extends StatelessWidget {
  final AppUser user;
  CreateTimetableScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransparentStatusbar(
      child: Scaffold(
        body: SafeArea(
          child: GetBuilder<CreateTimetableController>(
            init: CreateTimetableController(),
            builder: (controller) => Column(
              children: [
                header(context, controller),
                form(context, controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context, CreateTimetableController controller) =>
      Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 16.0,
          right: MediaQuery.of(context).size.width * 0.33,
        ),
        height: 40,
        color: kPrimaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: controller.goBack,
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            Center(
              child: Text(
                'Create New Timetable',
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

  Widget form(BuildContext context, CreateTimetableController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'Day of the week',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.timetableDayController,
                  validator: controller.validateNotEmpty,
                ),
//                AppDropdown(
//                  items: [
//                    'Monday',
//                    'Tuesday',
//                    'Wednesday',
//                    'Thursday',
//                    'Friday',
//                    'Saturday',
//                    'Sunday'
//                  ],
//                  text: 'Day of the week',
//                  onChanged: (val) => dayofWeek = val,
//                  value: 'Monday',
//                  controller: controller.timetableDayController,
//                  validator: (val) =>
//                      val == 'Select Day' ? 'Please select a valid day' : null,
//                ),
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'Subject',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.timetableSubjectController,
                  validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  maxLines: 3,
                  text: 'Location',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.timetableLocationController,
                  validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.selectStartTime(context);
                        },
                        child: AppTextField(
                          text: 'Start Time',
                          hintText: 'Select Time',
                          validator: controller.validateNotEmpty,
                          controller: controller.startTimeController,
                          enabled: false,
                          prefixIcon: Icon(Icons.history),
                        ),
                      ),
                    ),
                    kMediumHorizontalSpacing,
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.selectEndTime(context);
                        },
                        child: AppTextField(
                          text: 'End Time',
                          hintText: 'Set Time',
                          validator: controller.validateNotEmpty,
                          controller: controller.endTimeController,
                          enabled: false,
                          prefixIcon: Icon(Icons.history),
                        ),
                      ),
                    ),
                  ],
                ),
                kLargeVerticalSpacing,
                AppButton(
                  label: 'Create Timetable',
                  color: kPrimaryColor,
                  isLoading: controller.state == NotifierState.isLoading,
                  textColor: Colors.white,
                  onPressed: controller.state == NotifierState.isLoading
                      ? null
                      : controller.createTimetable,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//import 'package:flutter/material.dart';
//import 'package:my_study_pal/src/core/constants.dart';
//import 'package:my_study_pal/src/views/screens/task_screen.dart';
//import 'package:my_study_pal/src/views/widgets/app_button.dart';
//import 'package:my_study_pal/src/views/widgets/app_dropdown.dart';
//import 'package:my_study_pal/src/views/widgets/app_textfield.dart';
//
//class CreateTimetableScreen extends StatefulWidget {
//  @override
//  _CreateTimetableScreenState createState() => _CreateTimetableScreenState();
//}
//
//class _CreateTimetableScreenState extends State<CreateTimetableScreen> {
//  final _formKey = GlobalKey<FormState>();
//  final _scaffoldKey = GlobalKey<ScaffoldState>();
//
//  String dayofWeek;
//
//  int rvalue = 0;
//  void method1(value) {
//    setState(() {
//      rvalue = value;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      key: _scaffoldKey,
//      appBar: AppBar(
//        leading: GestureDetector(
//            onTap: () => Navigator.pop(context),
//            child: Icon(Icons.arrow_back_ios, color: kBlackColor)),
//        title: Text(
//          'Create Timetable',
//          style: TextStyle(color: kBlackColor),
//        ),
//        elevation: 0.0,
//        backgroundColor: Colors.transparent,
//      ),
//      body: Padding(
//        padding: const EdgeInsets.symmetric(horizontal: 16.0),
//        child: SingleChildScrollView(
//          scrollDirection: Axis.vertical,
//          child: Form(
//            key: _formKey,
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: [
//                kMediumVerticalSpacing,
//                AppDropdown(
//                  items: [
//                    'Monday',
//                    'Tuesday',
//                    'Wednesday',
//                    'Thursday',
//                    'Friday',
//                    'Saturday',
//                    'Sunday'
//                  ],
//                  text: 'Day of the week',
//                  onChanged: (val) => dayofWeek = val,
//                  value: 'Monday',
//                  validator: (val) => val == 'Select Day'
//                      ? 'Please select a valid marital status'
//                      : null,
//                ),
//                kMediumVerticalSpacing,
//                AppTextField(
//                  text: 'Subject',
//                  keyboardType: TextInputType.text,
//                  textInputAction: TextInputAction.next,
//                  validator: validateNotEmpty,
//                ),
//                kMediumVerticalSpacing,
//                AppTextField(
//                  text: 'Location',
//                  keyboardType: TextInputType.datetime,
//                  textInputAction: TextInputAction.next,
//                  validator: validateNotEmpty,
//                ),
//                kMediumVerticalSpacing,
//                AppTextField(
//                  text: 'Start Time',
//                  keyboardType: TextInputType.datetime,
//                  textInputAction: TextInputAction.next,
//                  validator: validateNotEmpty,
//                ),
//                kMediumVerticalSpacing,
//                AppTextField(
//                  text: 'End Time',
//                  keyboardType: TextInputType.datetime,
//                  textInputAction: TextInputAction.next,
//                  validator: validateNotEmpty,
//                ),
//                kLargeVerticalSpacing,
//                Text(
//                  'Get Notification',
//                  style: kHeadingTextStyle,
//                ),
//                Row(
//                  children: [
//                    Radio(
//                      value: 1,
//                      groupValue: rvalue,
//                      activeColor: kPrimaryColor,
//                      onChanged: (int rval) {
//                        method1(rval);
//                      },
//                    ),
//                    Text('15 minutes to the start time'),
//                  ],
//                ),
//                Row(
//                  children: [
//                    Radio(
//                      value: 2,
//                      groupValue: rvalue,
//                      activeColor: kPrimaryColor,
//                      onChanged: (int rval) {
//                        method1(rval);
//                      },
//                    ),
//                    Text('30 minutes to the start time'),
//                  ],
//                ),
//                Row(
//                  children: [
//                    Radio(
//                      value: 3,
//                      groupValue: rvalue,
//                      activeColor: kPrimaryColor,
//                      onChanged: (int rval) {
//                        method1(rval);
//                      },
//                    ),
//                    Text('60 minutes to the start time'),
//                  ],
//                ),
//                kLargeVerticalSpacing,
//                Row(
//                  children: [
//                    Expanded(
//                      child: AppButton(
//                          label: 'Create Timetable',
//                          textColor: Colors.white,
//                          color: kPrimaryColor,
//                          onPressed: () {
//                            // _createTimetable();
//                          }),
//                    )
//                  ],
//                ),
//                kLargeVerticalSpacing,
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//
//  // void _createTimetable() {
//  //   FocusScope.of(context).unfocus();
//
//  //   if (_formKey.currentState.validate()) {
//  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
//  //       builder: (context) => ScheduleScreen(),
//  //     ));
//  //   }
//  // }
//}
//
//String validateNotEmpty(String value) =>
//    value.isEmpty ? 'Field cannot be empty' : null;

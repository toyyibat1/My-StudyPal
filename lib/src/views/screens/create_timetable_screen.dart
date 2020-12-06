import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/views/screens/schedule_screen.dart';
import 'package:my_study_pal/src/views/widgets/app_button.dart';
import 'package:my_study_pal/src/views/widgets/app_dropdown.dart';
import 'package:my_study_pal/src/views/widgets/app_textfield.dart';

class CreateTimetableScreen extends StatefulWidget {
  @override
  _CreateTimetableScreenState createState() => _CreateTimetableScreenState();
}

class _CreateTimetableScreenState extends State<CreateTimetableScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String dayofWeek;

  int rvalue = 0;
  void method1(value) {
    setState(() {
      rvalue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios, color: kBlackColor)),
        title: Text(
          'Create Timetable',
          style: TextStyle(color: kBlackColor),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kMediumVerticalSpacing,
                AppDropdown(
                  items: [
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday'
                  ],
                  text: 'Day of the week',
                  onChanged: (val) => dayofWeek = val,
                  value: 'Monday',
                  validator: (val) => val == 'Select Day'
                      ? 'Please select a valid marital status'
                      : null,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'Subject',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'Location',
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  validator: validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'Start Time',
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  validator: validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'End Time',
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  validator: validateNotEmpty,
                ),
                kLargeVerticalSpacing,
                Text(
                  'Get Notification',
                  style: kHeadingTextStyle,
                ),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: rvalue,
                      activeColor: kPrimaryColor,
                      onChanged: (int rval) {
                        method1(rval);
                      },
                    ),
                    Text('15 minutes to the start time'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: rvalue,
                      activeColor: kPrimaryColor,
                      onChanged: (int rval) {
                        method1(rval);
                      },
                    ),
                    Text('30 minutes to the start time'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 3,
                      groupValue: rvalue,
                      activeColor: kPrimaryColor,
                      onChanged: (int rval) {
                        method1(rval);
                      },
                    ),
                    Text('60 minutes to the start time'),
                  ],
                ),
                kLargeVerticalSpacing,
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                          label: 'Create Timetable',
                          textColor: Colors.white,
                          color: kPrimaryColor,
                          onPressed: () {
                            _createTimetable();
                          }),
                    )
                  ],
                ),
                kLargeVerticalSpacing,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createTimetable() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState.validate()) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ScheduleScreen(),
      ));
    }
  }
}

String validateNotEmpty(String value) =>
    value.isEmpty ? 'Field cannot be empty' : null;

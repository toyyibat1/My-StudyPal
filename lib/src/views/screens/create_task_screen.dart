import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/views/screens/schedule_screen.dart';
import 'package:my_study_pal/src/views/widgets/app_button.dart';
import 'package:my_study_pal/src/views/widgets/app_textfield.dart';

class CreateTaskScreen extends StatefulWidget {
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios, color: kBlackColor)),
        title: Text(
          'Create New Task',
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
              children: [
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'Task Name',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'Task Description',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'Date',
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
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                          label: 'Create Task',
                          textColor: Colors.white,
                          color: kPrimaryColor,
                          onPressed: () {
                            _createTask();
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

  void _createTask() {
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

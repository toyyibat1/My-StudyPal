import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/views/widgets/app_textfield.dart';

class AddScheduleScreen extends StatefulWidget {
  @override
  _AddScheduleScreenState createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('School Schedule'),
        backgroundColor: kPrimaryColor,
        leading: GestureDetector(
          onTap: ()=>Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              kMediumVerticalSpacing,
              AppTextField(
                text: 'Start of Semester',
              ),
              kMediumVerticalSpacing,
              AppTextField(
                text: 'End of Semester',
              ),
              kMediumVerticalSpacing,
              AppTextField(
                text: 'Start of Exams',
              ),
              kMediumVerticalSpacing,
              AppTextField(
                text: 'End of Exams',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
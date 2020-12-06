import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/validation_mixin.dart';
import 'package:my_study_pal/src/views/widgets/app_button.dart';
import 'package:my_study_pal/src/views/widgets/app_textfield.dart';

class AddStudyGoals extends StatefulWidget {
  @override
  _AddStudyGoalsState createState() => _AddStudyGoalsState();
}

class _AddStudyGoalsState extends State<AddStudyGoals> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Study Goals'),
        leading: GestureDetector(
          onTap: ()=> Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
               kMediumVerticalSpacing,
              AppTextField(
                height: 7,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  text: 'What are your study goals',
                  ),
              kMediumVerticalSpacing,
              AppTextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                text: 'When did you want your goal to be achieved?',
              ),
              kMediumVerticalSpacing,
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Create Study Goals',
                      color: kPrimaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        _addGoal();
                      },
                    ),
                  ),
                ],
              ),
          ],),),
      ),
    );
  
  }
  void _addGoal() {
    FocusScope.of(context).unfocus();
    if(_formKey.currentState.validate()){
      if (_formKey.currentState.validate()) {
      Navigator.pop(context);
      }
    }
  }
}
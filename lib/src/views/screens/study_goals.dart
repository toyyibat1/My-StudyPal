
import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';

import 'add_study_goals.dart';

class StudyGoalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Goals'),
        backgroundColor: kPrimaryColor,
        leading: GestureDetector(
          onTap: ()=> Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios)
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
              Image.asset(
                goal,
                width: 100,
                color: Colors.grey,
              ),
              kSmallVerticalSpacing,
              Text(
                'No Goals',
                style: kLabelText,
              ),
            ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddStudyGoals()));
        }),
    );
  }
}
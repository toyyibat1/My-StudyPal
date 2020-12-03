
import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';

class BadgesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Badges'),
        backgroundColor: kPrimaryColor,
        leading: GestureDetector(
          onTap: ()=>Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';

class InviteSucessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invite Friends'),
        backgroundColor: kPrimaryColor,
        leading: GestureDetector(
          onTap: ()=>Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(mark),
            kLargeVerticalSpacing,
            Text('Invitation Sent Successfully')
          ],
        ),
      ),
    );
  }
}
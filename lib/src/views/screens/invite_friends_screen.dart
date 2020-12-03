import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/views/screens/invites_success_screen.dart';
import 'package:my_study_pal/src/views/widgets/app_button.dart';
import 'package:my_study_pal/src/views/widgets/app_textfield.dart';

class InviteFriendScreen extends StatefulWidget {
  @override
  _InviteFriendScreenState createState() => _InviteFriendScreenState();
}

class _InviteFriendScreenState extends State<InviteFriendScreen> {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                kMediumVerticalSpacing,
                Text('Invite your friends to download\nmystudypadi app and view created tasks',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),),
                kLargeVerticalSpacing,
                Image.asset(invite,),
                kLargeVerticalSpacing,
                AppTextField(
                text: 'Email',
                hintText: 'Email Address',
                ),
                kLargeVerticalSpacing,
                Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Send Invites',
                      color: kPrimaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> InviteSucessScreen()));
                      },
                    ),
                  ),
                ],
              ),
          
              ],
            ),
          )),
      ),
    );
  }
}
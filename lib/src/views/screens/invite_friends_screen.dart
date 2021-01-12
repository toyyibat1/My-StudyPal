import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/controller/invite_friends_controller.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/views/widgets/app_button.dart';

class InviteFriendScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return GetBuilder<InviteFriendsController>(
        init: InviteFriendsController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text('Invite Friends'),
                backgroundColor: kPrimaryColor,
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
              body: SafeArea(
                  child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Invite your friends to download\nmystudypadi app and view created tasks',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                      kLargeVerticalSpacing,
                      Image.asset(
                        invite,
                      ),
                      kLargeVerticalSpacing,
//              AppTextField(
//                text: '',
//                hintText: 'Enter email address',
//              ),
//              kLargeVerticalSpacing,
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                                label: 'Send Invites',
                                color: kPrimaryColor,
                                textColor: Colors.white,
                                onPressed: () => controller.urlFileShare()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
            ));
  }
}

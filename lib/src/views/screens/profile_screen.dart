import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/profile_controller.dart';
import '../../core/constants.dart';
import '../../core/notifier.dart';
import '../widgets/app_tile.dart';
import '../widgets/profile_tile.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController()..getAuthenticatedUser(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'My Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          )),
          elevation: 0,
          backgroundColor: kPrimaryColor2,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//              header,
              Expanded(
                  child: controller.state == NotifierState.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : profileActions(controller)),
            ],
          ),
        ),
      ),
    );
  }

  Widget get header => Container(
        width: double.infinity,
        height: 40,
        color: kPrimaryColor2,
        child: Center(
          child: Text(
            'My Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      );

  Widget profileActions(ProfileController controller) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kMediumVerticalSpacing,
          ProfileTile(
            leading: CircleAvatar(
              radius: 35,
              backgroundColor: Color(0xff102A67),
              child: ClipOval(
                child: new SizedBox(
                  width: 70.0,
                  height: 70.0,
                  child: Image.file(File(controller.user.photoUrl)) == null
                      ? CircleAvatar(
                          backgroundColor: Color(0xFFEEEBF3),
                          radius: 40,
                          child: Text(
                            controller.user.firstName[0],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        )
                      : Image.file(File(controller.user.photoUrl),
                          fit: BoxFit.cover),
                ),
              ),
            ),
            title: '${controller.user.firstName} ${controller.user.lastName}',
            email: controller.user.emailAddress,
            subtitle: Text(controller.user.institution),
          ),
          kSmallVerticalSpacing,
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              'General',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          AppTile(
            onPressed: controller.navigateToEditProfileScreen,
            leading: Icons.person,
            title: 'Edit Profile',
            trailing: Icons.arrow_forward_ios,
          ),
          AppTile(
            onPressed: controller.navigateToBadgesScreen,
            leading: Icons.badge,
            title: 'Badges',
            trailing: Icons.arrow_forward_ios,
          ),
          AppTile(
            onPressed: controller.navigateToStudyGoalsScreen,
            leading: Icons.control_point_rounded,
            title: 'Study Goals',
            trailing: Icons.arrow_forward_ios,
          ),
          AppTile(
            onPressed: controller.navigateToFocusModeScreen,
            leading: Icons.notifications_off,
            title: 'Focus Mode',
            trailing: Icons.arrow_forward_ios,
          ),
          AppTile(
            onPressed: controller.navigateToAddScheduleScreen,
            leading: Icons.next_plan_sharp,
            title: 'School Schedule',
            trailing: Icons.arrow_forward_ios,
          ),
          AppTile(
            onPressed: controller.navigateToInviteFriendScreen,
            leading: Icons.people,
            title: 'Invite Friends',
            trailing: Icons.arrow_forward_ios,
          ),
          AppTile(
            onPressed: controller.confirmSignOut ??
                controller.signOutWithGoogle ??
                controller.signOutWithFacebook,
            leading: Icons.logout,
            title: 'Log Out',
            trailing: Icons.arrow_forward_ios,
          ),
          kExtraSmallVerticalSpacing,
          Center(
            child: Text(
              'MyStudyPadi V 1.0',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          kExtraSmallVerticalSpacing,
        ],
      ),
    );
  }
}

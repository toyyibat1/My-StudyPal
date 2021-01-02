import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/services/google_signin.dart';

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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header,
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
              // backgroundImage: AssetImage(welcome),
              child: Text(
                controller.user.firstName[0],
                style: kHeadingTextStyle,
              ) ,
              backgroundColor: Color(0xFFE0E0E0),
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
            onPressed: controller.signOut ?? controller.signOutWithGoogle ?? controller.signOutWithFacebook,
            leading: Icons.logout,
            title: 'Log Out',
            trailing: Icons.arrow_forward_ios,
          ),
          kExtraSmallVerticalSpacing,
          Center(
              child: Text(
            'MyStudyPadi V 1.0',
            style: TextStyle(color: Colors.grey),
          )),
          kExtraSmallVerticalSpacing,

//          Center(
//              child: Text(
//            'V 1.0',
//            style: TextStyle(color: Colors.grey),
//          )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_study_pal/src/controller/auth_controller.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/models/app_user.dart';
import 'package:my_study_pal/src/services/google_signin.dart';
import 'package:my_study_pal/src/views/screens/badges_screen.dart';
import 'package:my_study_pal/src/views/screens/invite_friends_screen.dart';
import 'package:my_study_pal/src/views/screens/study_goals.dart';

import 'schedule.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final AppUser user;
  const ProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthController authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      color: kPrimaryColor,
                      child: Center(
                          child: Text(
                        'My Profile',
                        style: kHeadingTextStyle.copyWith(color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kMediumVerticalSpacing,
                      Card(
                        child: ListTile(
                          title: Text(
                            name ??
                                (authController.firestoreUser.value.firstName +
                                    ' ' +
                                    authController
                                        .firestoreUser.value.lastName),
                            style: kHeadingTextStyle,
                          ),
                          subtitle: Text(emailAddress ??
                              (authController.firestoreUser.value.email)),
                          leading: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(welcome),
                          ),
                        ),
                      ),
                      kSmallVerticalSpacing,
                      Text(
                        'General',
                        style: kHeadingTextStyle,
                      ),
                      ProfileCard(
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfileScreen()));
                        },
                        text: 'Edit Profile',
                        icon: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                      ),
                      kExtraSmallVerticalSpacing,
                      ProfileCard(
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BadgesScreen()));
                        },
                        text: 'Badges',
                        icon: Icon(
                          Icons.badge,
                          color: kPrimaryColor,
                        ),
                      ),
                      kExtraSmallVerticalSpacing,
                      ProfileCard(
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudyGoalsScreen()));
                        },
                        text: 'Study Goals',
                        icon: Icon(
                          Icons.control_point_rounded,
                          color: kPrimaryColor,
                        ),
                      ),
                      kExtraSmallVerticalSpacing,
                      ProfileCard(
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScheduleScreen()));
                        },
                        text: 'School Schedule',
                        icon: Icon(
                          Icons.next_plan,
                          color: kPrimaryColor,
                        ),
                      ),
                      kExtraSmallVerticalSpacing,
                      ProfileCard(
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InviteFriendScreen()));
                        },
                        text: 'Invite Friends',
                        icon: Icon(
                          Icons.people,
                          color: kPrimaryColor,
                        ),
                      ),
                      kExtraSmallVerticalSpacing,
                      ProfileCard(
                        ontap: () async {
                          await authController.signOut();
                        },
                        text: 'Log Out',
                        icon: Icon(
                          Icons.logout,
                          color: kPrimaryColor,
                        ),
                      ),
                      kExtraSmallVerticalSpacing,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final Icon icon;
  final String text;
  final Function ontap;

  const ProfileCard({Key key, this.icon, this.text, this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: icon,
            title: Text(
              text,
              style: kBodyText2TextStyle,
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );
  }
}

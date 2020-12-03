import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/views/screens/add_schedule_screen.dart';
import 'package:my_study_pal/src/views/screens/badges_screen.dart';
import 'package:my_study_pal/src/views/screens/invite_friends_screen.dart';
import 'package:my_study_pal/src/views/screens/study_goals.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('My Profile')),
        backgroundColor: kPrimaryColor2,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
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
                          'Tope Adeniran',
                          style: kHeadingTextStyle,
                        ),
                        subtitle: Text('topeadeniran@gmail.com'),
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
                                builder: (context) => AddScheduleScreen()));
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
                      ontap: () {},
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

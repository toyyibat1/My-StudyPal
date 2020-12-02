import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                        ontap: () {},
                        text: 'Edit Profile',
                        icon: Icon(
                          Icons.edit_outlined,
                          color: kPrimaryColor,
                        ),
                      ),
                      kExtraSmallVerticalSpacing,
                      ProfileCard(
                        ontap: () {},
                        text: 'Badges',
                        icon: Icon(
                          Icons.badge,
                          color: kPrimaryColor,
                        ),
                      ),
                      kExtraSmallVerticalSpacing,
                      ProfileCard(
                        ontap: () {},
                        text: 'Study Goals',
                        icon: Icon(
                          Icons.control_point_rounded,
                          color: kPrimaryColor,
                        ),
                      ),
                      kExtraSmallVerticalSpacing,
                      ProfileCard(
                        ontap: () {},
                        text: 'School Schedule',
                        icon: Icon(
                          Icons.next_plan,
                          color: kPrimaryColor,
                        ),
                      ),
                      kExtraSmallVerticalSpacing,
                      ProfileCard(
                        ontap: () {},
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

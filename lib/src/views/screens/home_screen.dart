import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../core/constants.dart';
import '../../models/app_user.dart';
import '../widgets/nav_bar.dart';
import '../widgets/transparent_statusbar.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';
import 'task_screen.dart';
import 'timetable_screen.dart';

class HomeScreen extends StatelessWidget {
  final AppUser user;
  HomeScreen({Key key, this.user}) : super(key: key);

  final List<Widget> _children = [
    DashboardScreen(),
    TaskScreen(),
    TimetableScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return TransparentStatusbar(
      child: GetBuilder<HomeController>(
        init: HomeController(user: user),
        builder: (controller) => Scaffold(
          body: _children[controller.currentPage],
          bottomNavigationBar: NavBar(
            backgroundColor: Colors.white,
            color: Colors.black54,
            selectedColor: kPrimaryColor2,
            onTabSelected: controller.onTabSelected,
            items: [
              NavBarItem(iconData: Icons.home, text: 'Home'),
              NavBarItem(iconData: Icons.today, text: 'Tasks'),
              NavBarItem(iconData: Icons.timelapse_rounded, text: 'Timetable'),
              NavBarItem(iconData: Icons.person_outline, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}

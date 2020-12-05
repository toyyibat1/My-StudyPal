import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/controller/auth_controller.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/views/screens/dashboard_screen.dart';
import 'package:my_study_pal/src/views/screens/profile_screen.dart';
import 'package:my_study_pal/src/views/screens/schedule_screen.dart';
import 'package:my_study_pal/src/views/screens/timetable_screen.dart';
import 'package:my_study_pal/src/views/widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    DashboardScreen(),
    ScheduleScreen(),
    TimetableScreen(),
    ProfileScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
       builder: (controller) => controller?.firestoreUser?.value?.firstName == null
          ? Center(
              child: CircularProgressIndicator(),
      )
          : Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: NavBar(
        backgroundColor: Colors.white,
        color: Colors.black54,
        selectedColor: kPrimaryColor2,
        onTabSelected: _onTabSelected,
        items: [
          NavBarItem(iconData: Icons.home, text: 'Home'),
          NavBarItem(iconData: Icons.today, text: 'Schedule'),
          NavBarItem(iconData: Icons.timelapse_rounded, text: 'Timetable'),
          NavBarItem(iconData: Icons.person_outline, text: 'Profile'),
        ],
      ),
    ));
    
  }
}

import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/views/screens/create_timetable_screen.dart';

class TimetableScreen extends StatefulWidget {
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CreateTimetableScreen())),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                        'Timetable',
                        style: kHeadingTextStyle.copyWith(color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    timetable,
                    width: 100,
                    color: Colors.grey,
                  ),
                  kSmallVerticalSpacing,
                  Text(
                    'No Timetable',
                    style: kLabelText,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

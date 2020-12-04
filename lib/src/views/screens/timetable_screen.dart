import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/views/screens/create_timetable_screen.dart';

class TimetableScreen extends StatefulWidget {
  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Timetable')),
        backgroundColor: kPrimaryColor2,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CreateTimetableScreen())),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _timetable(),
        ),
      ),
    );
  }

//  Center(
//  child: Image.asset(
//  timetable,
//  width: 100,
//  color: Colors.grey,
//  ),
//  ),
//  kSmallVerticalSpacing,
//  Text(
//  'No Timetable',
//  style: kLabelText,
//  ),
  Widget _timetable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Monday',
          style: kLabelText,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => Row(
              children: [
                Expanded(
                  child: AppContainer(
                    color: kPrimaryColor,
                    tasktitle: 'Reading About Ethics',
                    icon: Icon(
                      Icons.pending,
                      color: kPrimaryColor,
                    ),
                    tasklocation: 'LTA',
                    tasktime: '09:00 AM - 12:00 PM',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AppContainer extends StatelessWidget {
  final Color color;
  final Icon icon;
  final String tasktitle;
  final String tasktime;
  final String tasklocation;

  const AppContainer({
    Key key,
    this.color,
    this.icon,
    this.tasktitle,
    this.tasklocation,
    this.tasktime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kExtraSmallVerticalSpacing,
        Container(
          decoration: BoxDecoration(
            color: kSecondaryColor,
//            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            border: Border(
              left: BorderSide(
                color: kPrimaryColor,
                width: 8.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tasktitle,
                      style: kBodyText2TextStyle,
                    ),
                    kExtraSmallVerticalSpacing,
                    Row(
                      children: [
                        Icon(Icons.timer),
                        Text(
                          tasktime,
                          style: kLabelText,
                        ),
                        kSmallHorizontalSpacing,
                        Icon(Icons.location_on),
                        Text(
                          tasklocation,
                          style: kLabelText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

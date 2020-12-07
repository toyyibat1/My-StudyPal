import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/views/screens/create_task_screen.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Task')),
        backgroundColor: kPrimaryColor2,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
        onPressed: () {},
        // onPressed: () => Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => CreateTaskScreen())),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _tasks(),
        ),
      ),
    );
  }

//            Center(
//              child: Image.asset(
//                task,
//                width: 100,
//                color: Colors.grey,
//              ),
//            ),
//            kSmallVerticalSpacing,
//            Text(
//              'No Tasks',
//              style: kLabelText,
//            ),
  Widget _tasks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today',
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

  const AppContainer({Key key, this.color, this.icon, this.tasktitle})
      : super(key: key);

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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                          '01:00 PM - 02:00 PM',
                          style: kLabelText,
                        ),
                      ],
                    ),
                    Text(
                      'plan to finish maths assignment',
                      style: kLabelText,
                    ),
                  ],
                ),
                SizedBox(
                  width: 16,
                ),
                icon,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

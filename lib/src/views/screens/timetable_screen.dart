import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/controller/timetable_controller.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/views/widgets/timetable_tile.dart';

import '../../core/constants.dart';
import '../../core/notifier.dart';

class TimetableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimetableController>(
      init: TimetableController(),
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              header,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                  child: controller.state == NotifierState.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : controller.timetables.isEmpty
                          ? Center(
                              child: SizedBox(
                                height: 180,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      timetable,
                                      color: Colors.grey.shade300,
                                    ),
                                    SizedBox(height: 8.0),
                                    Center(
                                      child: Text(
                                        'No Timetable',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: controller.timetables.length,
                              itemBuilder: (context, index) {
                                return TimetableTile(
                                  index: index,
                                  timetables: controller.timetables,
                                  controller: controller,
                                );
                              },
                            ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.add),
          onPressed: controller.navigateToCreateTimetable,
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
            'Timetable',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      );
}

//import 'package:flutter/material.dart';
//import '../../core/constants.dart';
//import '../../models/app_user.dart';
//import 'create_timetable_screen.dart';
//
//class TimetableScreen extends StatefulWidget {
//  final AppUser user;
//  const TimetableScreen({Key key, this.user}) : super(key: key);
//
//  @override
//  _TimetableScreenState createState() => _TimetableScreenState();
//}
//
//class _TimetableScreenState extends State<TimetableScreen> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        automaticallyImplyLeading: false,
//        title: Center(child: Text('Timetable')),
//        backgroundColor: kPrimaryColor2,
//      ),
//      floatingActionButton: FloatingActionButton(
//        backgroundColor: kPrimaryColor,
//        child: Icon(Icons.add),
//        onPressed: () => Navigator.of(context).push(
//            MaterialPageRoute(builder: (context) => CreateTimetableScreen())),
//      ),
//      body: SafeArea(
//        child: Padding(
//          padding: const EdgeInsets.all(16.0),
//          child: _timetable(),
//        ),
//      ),
//    );
//  }
//
////  Center(
////  child: Image.asset(
////  timetable,
////  width: 100,
////  color: Colors.grey,
////  ),
////  ),
////  kSmallVerticalSpacing,
////  Text(
////  'No Timetable',
////  style: kLabelText,
////  ),
//  Widget _timetable() {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: [
//        Text(
//          'Monday',
//          style: kLabelText,
//        ),
//        Expanded(
//          child: ListView.builder(
//            itemCount: 10,
//            itemBuilder: (context, index) => Row(
//              children: [
//                Expanded(
//                  child: AppContainer(
//                    color: kPrimaryColor,
//                    tasktitle: 'Reading About Ethics',
//                    icon: Icon(
//                      Icons.pending,
//                      color: kPrimaryColor,
//                    ),
//                    tasklocation: 'LTA',
//                    tasktime: '09:00 AM - 12:00 PM',
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
//      ],
//    );
//  }
//}
//
//class AppContainer extends StatelessWidget {
//  final Color color;
//  final Icon icon;
//  final String tasktitle;
//  final String tasktime;
//  final String tasklocation;
//
//  const AppContainer({
//    Key key,
//    this.color,
//    this.icon,
//    this.tasktitle,
//    this.tasklocation,
//    this.tasktime,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: [
//        kExtraSmallVerticalSpacing,
//        Container(
//          decoration: BoxDecoration(
//            color: kSecondaryColor,
////            borderRadius: BorderRadius.all(Radius.circular(12.0)),
//            border: Border(
//              left: BorderSide(
//                color: kPrimaryColor,
//                width: 8.0,
//              ),
//            ),
//          ),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: [
//              Padding(
//                padding: const EdgeInsets.all(16.0),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                    Text(
//                      tasktitle,
//                      style: kBodyText2TextStyle,
//                    ),
//                    kExtraSmallVerticalSpacing,
//                    Row(
//                      children: [
//                        Icon(Icons.timer),
//                        Text(
//                          tasktime,
//                          style: kLabelText,
//                        ),
//                        kSmallHorizontalSpacing,
//                        Icon(Icons.location_on),
//                        Text(
//                          tasklocation,
//                          style: kLabelText,
//                        ),
//                      ],
//                    ),
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ),
//      ],
//    );
//  }
//}

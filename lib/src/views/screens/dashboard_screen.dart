import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_study_pal/src/controller/auth_controller.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/services/google_signin.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AuthController authController = AuthController.to;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(12, MediaQuery.of(context).size.height / 4),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                      text: "Welcome,\n",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                      ),
                      children: [
                        TextSpan(
                          text: name ?? 
                              (authController.firestoreUser.value.firstName + ' ' + authController.firestoreUser.value.lastName ),
                          style: TextStyle(
                              color: kBlackColor,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ]),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(welcome),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                kMediumVerticalSpacing,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Expanded(
                      child: AppContainer2(
                        text: '06',
                        headText: 'Number of Pending Task',
                        color: kPrimaryColor2,
                      ),
                    ),
                    kSmallHorizontalSpacing,
                    Expanded(
                      child: AppContainer2(
                        text: '10',
                        headText: 'Number of Completed Task',
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                kMediumVerticalSpacing,
                _pending(),
                kMediumVerticalSpacing,
                _completed(),
                kMediumVerticalSpacing,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _pending() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pending',
          style: kLabelText,
        ),
        Container(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 3),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => Row(
              children: [
                Expanded(
                  child: AppContainer(
                    date: 'Mon\n 18',
                    year: '2020',
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

  Widget _completed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Completed',
          style: kLabelText,
        ),
        Container(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 3),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => Row(
              children: [
                Expanded(
                  child: AppContainer(
                    date: 'Mon\n 18',
                    year: '2020',
                    color: kPrimaryColor2,
                    tasktitle: 'Finish MTH Assignment',
                    icon: Icon(
                      Icons.done_outline,
                      color: kPrimaryColor2,
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
  final String date;
  final String year;
  final String tasktitle;

  const AppContainer(
      {Key key, this.color, this.icon, this.date, this.year, this.tasktitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kExtraSmallVerticalSpacing,
        Container(
          decoration: BoxDecoration(
              color: kSecondaryColor, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12))),
                child: Column(
                  children: [
                    Text(
                      date,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      year,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              kSmallHorizontalSpacing,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        tasktitle,
                        style: kBodyText2TextStyle,
                      ),
                      kSmallVerticalSpacing,
                      Row(
                        children: [
                          Icon(Icons.timer),
                          Text(
                            '01:00 PM - 02:00 PM',
                            style: kLabelText,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                  ),
                  icon,
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AppContainer2 extends StatelessWidget {
  final Color color;
  final String headText;
  final String text;

  const AppContainer2({Key key, this.color, this.headText, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 34),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          kExtraSmallVerticalSpacing,
          Text(
            headText,
            style: kLabelText.copyWith(
              fontSize: 16.0,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

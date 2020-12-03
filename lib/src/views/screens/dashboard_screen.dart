import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
                          text: 'Nike Adeniran',
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
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: [
//                      Text.rich(
//                        TextSpan(
//                            text: "Welcome,\n",
//                            style: TextStyle(
//                              color: Colors.grey,
//                              fontSize: 20.0,
//                            ),
//                            children: [
//                              TextSpan(
//                                text: 'Nike Adeniran',
//                                style: TextStyle(
//                                    color: kBlackColor,
//                                    fontSize: 25.0,
//                                    fontWeight: FontWeight.w600),
//                              ),
//                            ]),
//                      ),
//                      CircleAvatar(
//                        radius: 40,
//                        backgroundImage: AssetImage(welcome),
//                      ),
//                    ],
//                  ),
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
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppContainer(
                            title: 'Pending',
                            color: kPrimaryColor,
                            date: 'Mon\n18',
                            year: '2020',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AppContainer(
                            title: '',
                            color: kPrimaryColor2,
                            date: 'Mon\n18',
                            year: '2020',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                kMediumVerticalSpacing,
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppContainer(
                            title: 'Completed',
                            color: kPrimaryColor,
                            date: 'Mon\n18',
                            year: '2020',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AppContainer(
                            title: '',
                            color: kPrimaryColor2,
                            date: 'Mon\n18',
                            year: '2020',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                kMediumVerticalSpacing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppContainer extends StatelessWidget {
  final Color color;
  final String title;
  final String date;
  final String year;

  const AppContainer({
    Key key,
    this.color,
    this.title,
    this.date,
    this.year,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kLabelText,
        ),
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

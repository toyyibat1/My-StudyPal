import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_study_pal/src/controller/auth_controller.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';
import '../../services/google_signin.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AuthController authController = AuthController.to;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                kMediumVerticalSpacing,
                Row(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppContainer(
                        title: '',
                        width: MediaQuery.of(context).size.width / 1,
                        height: 160.0,
                        color: kPrimaryColor,
                      ),
                    ),
                    kSmallHorizontalSpacing,
                    Expanded(
                      child: AppContainer(
                        title: '',
                        width: MediaQuery.of(context).size.width / 1,
                        height: 160.0,
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
                            width: MediaQuery.of(context).size.width / 1,
                            height: 101.0,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AppContainer(
                            title: '',
                            width: MediaQuery.of(context).size.width / 1,
                            height: 101.0,
                            color: kPrimaryColor,
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
                            width: MediaQuery.of(context).size.width / 1,
                            height: 101.0,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AppContainer(
                            title: '',
                            width: MediaQuery.of(context).size.width / 1,
                            height: 101.0,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
  final double width;
  final double height;

  const AppContainer({
    Key key,
    this.color,
    this.title,
    this.width,
    this.height,
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
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(12)),
        ),
      ],
    );
  }
}

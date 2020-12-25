//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:my_study_pal/src/controller/study_goal_controller.dart';
//import 'package:my_study_pal/src/core/images.dart';
//import 'package:my_study_pal/src/views/widgets/app_textfield.dart';
//
//import '../../core/constants.dart';
//import '../../models/study_goals.dart';
//import 'app_button.dart';
//
//class StudyGoalTile extends StatelessWidget {
//  final int index;
//  final List<StudyGoal> studyGoals;
//  final StudyGoalController controller;
//
//  const StudyGoalTile({
//    Key key,
//    this.index,
//    this.studyGoals,
//    this.controller,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    final localizations = MaterialLocalizations.of(context);
//
//    Widget _showBottomSheet() {
//      showModalBottomSheet(
//          context: context,
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.only(
//                topLeft: Radius.circular(20.0),
//                topRight: Radius.circular(20.0)),
//          ),
//          builder: (builder) {
//            return Container(
//              padding: EdgeInsets.all(16.0),
//              child: Column(
//                children: [
//                  kLargeVerticalSpacing,
//                  Row(
//                    children: [
//                      Icon(Icons.map_rounded),
//                      SizedBox(width: 6),
//                      Text(
//                        studyGoals[index].studyGoalname,
//                        style: TextStyle(
//                          fontSize: 20,
//                          fontWeight: FontWeight.w400,
//                        ),
//                      ),
//                    ],
//                  ),
//                  kMediumVerticalSpacing,
//                  Row(
//                    children: [
//                      Icon(Icons.calendar_today),
//                      SizedBox(width: 6),
//                      Text(
//                        '${localizations.formatFullDate(studyGoals[index].date)}',
//                        style: TextStyle(
//                          fontSize: 20,
//                          fontWeight: FontWeight.w400,
//                        ),
//                      ),
//                    ],
//                  ),
//                  kMediumVerticalSpacing,
//                  Expanded(
//                    child: SizedBox(
//                      height: MediaQuery.of(context).size.height / 2,
//                    ),
//                  ),
//                  Row(
//                    children: [
//                      Expanded(
//                        child: AppButton(
//                          onPressed: () {},
//                          textColor: Colors.white,
//                          label: 'Delete',
//                          color: kPrimaryColor,
//                        ),
//                      ),
//                      kMediumHorizontalSpacing,
//                      Expanded(
//                        child: AppButton(
//                          onPressed: () {},
//                          textColor: Colors.white,
//                          label: 'Edit',
//                          color: kPrimaryColor,
//                        ),
//                      ),
//                    ],
//                  ),
//                ],
//              ),
//            );
//          });
//    }
//
//    return Padding(
//      padding: const EdgeInsets.symmetric(vertical: 8.0),
//      child: SizedBox(
//        height: 80,
//        child: ClipRRect(
//          borderRadius: BorderRadius.circular(50),
//          child: Row(
//            children: [
//              CircleAvatar(
//                backgroundColor: kPrimaryColor,
//                radius: 40,
//                backgroundImage: AssetImage(
//                  goal1,
//                ),
//              ),
//              Expanded(
//                child: Container(
//                  color: Color(0xFFF4F4F4),
//                  child: Padding(
//                    padding: const EdgeInsets.symmetric(
//                      horizontal: 16.0,
//                    ),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: [
//                        GestureDetector(
//                          onTap: () => _showBottomSheet(),
//                          child: Column(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: [
//                              Text(
//                                studyGoals[index].studyGoalname,
//                                style: TextStyle(
//                                  fontSize: 16,
//                                  fontWeight: FontWeight.w600,
//                                ),
//                              ),
//                              SizedBox(height: 16),
//                              Row(
//                                children: [
//                                  Icon(Icons.calendar_today),
//                                  SizedBox(width: 6),
//                                  Text(
//                                    '${localizations.formatFullDate(studyGoals[index].date)}',
//                                    style: TextStyle(
//                                      fontSize: 14,
//                                      fontWeight: FontWeight.w400,
//                                    ),
//                                  ),
//                                ],
//                              ),
//                              SizedBox(height: 16),
//                            ],
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}

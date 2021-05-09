import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_study_pal/src/controller/badges_controller.dart';
import 'package:my_study_pal/src/core/badges.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class GetAllBadges {
  String badgeTitle;
  String badgeDesc;
  int maxLength;
  int currentLength;
  GetAllBadges(
      {@required this.badgeTitle,
      @required this.badgeDesc,
      @required this.currentLength,
      @required this.maxLength});
}

class BadgeTile extends StatelessWidget {
  final List<GetAllBadges> allBadgesList = [
    GetAllBadges(
        badgeDesc: profileDescription,
        badgeTitle: profileBadgeTitle,
        currentLength: 4,
        maxLength: 7),
    GetAllBadges(
        badgeDesc: profileDescription,
        badgeTitle: profileBadgeTitle,
        currentLength: 4,
        maxLength: 7),
    GetAllBadges(
        badgeTitle: complete10TaskBadgeTitle,
        badgeDesc: complete10TaskDescription,
        currentLength: 4,
        maxLength: 7),
    GetAllBadges(
        badgeTitle: complete25TaskBadgeTitle,
        badgeDesc: complete25TaskDescription,
        currentLength: 4,
        maxLength: 7)
  ];
  final int index;
  final List<GetAllBadges> badges;
  final BadgeController controller;
  final String badgeTitle;
  final String badgeDesc;

  BadgeTile(
      {Key key,
      this.controller,
      this.badges,
      this.index,
      this.badgeTitle,
      this.badgeDesc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Color(0xFFF4F4F4),
            child: Row(
              children: [
                Image.asset(
                  badge,
                  width: 80,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        badges[index].badgeTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Text(
                          badges[index].badgeDesc,
                          style: kLabelText,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          StepProgressIndicator(
                            totalSteps: badges[index].maxLength,
                            currentStep: badges[index].currentLength,
                          ),
                          kSmallHorizontalSpacing,
                          Text(
                            "${badges[index].currentLength}/${badges[index].maxLength}",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

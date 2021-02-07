import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_study_pal/src/controller/badges_controller.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/models/badges.dart';

class BadgeTile extends StatelessWidget {
  final int index;
  final List<Badge> badges;
  final BadgeController controller;

  const BadgeTile({Key key, this.controller, this.badges, this.index})
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
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35,
                  child: Image.asset(
                    "assets/badge.PNG",
                    width: 36,
                  ),
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
                          badges[index].desc,
                          style: kLabelText,
                          overflow: TextOverflow.ellipsis,
                        ),
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

import 'package:flutter/material.dart';
import 'package:my_study_pal/src/controller/badges_controller.dart';
import 'package:my_study_pal/src/models/badges.dart';

import '../../controller/timetable_controller.dart';
import '../../core/constants.dart';
import '../../core/images.dart';
import '../../models/timetable.dart';

import 'package:flutter/cupertino.dart';
import 'package:my_study_pal/src/controller/timetable_controller.dart';

class BadgeTile extends StatelessWidget {
  final int index;
  final List<Badge> badges;
  final BadgeController controller;

  const BadgeTile (
      {Key key, this.controller, this.badges, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              // Container(
              //   width: 18,
              //  // color: kPrimaryColor,
              //   child: Image.asset("assets/badge.png"),
              // ),
              Expanded(
                child: Container(
                  color: Color(0xFFF4F4F4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: Text(
                                  badges[index].badgeTitle,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                               // SizedBox(width: 6),
                                Text(
                                   badges[index].desc,
                                 style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                               // SizedBox(width: 12),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

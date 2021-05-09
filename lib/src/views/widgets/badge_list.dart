import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_study_pal/src/controller/badges_controller.dart';
import 'package:my_study_pal/src/controller/dashboard_controller.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/models/badges.dart';

import '../../core/constants.dart';
import '../../models/timetable.dart';

class BadgeList extends StatelessWidget {
  final String title;
  final Color tagColor;
  final List<Badge> badges;
  final BadgeController controller;

  const BadgeList({
    Key key,
    @required this.title,
    @required this.badges,
    @required this.tagColor,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 8),
        badges.isEmpty
            ? SizedBox(
                height: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      timetable,
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: 8.0),
                    Center(
                      child: Text(
                        'No Badges',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                constraints: BoxConstraints(maxHeight: 324),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: badges.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: SizedBox(
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Row(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                color: tagColor,
                              ),
                              Expanded(
                                child: Container(
                                  color: Color(0xFFF4F4F4),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              badges[index].badgeTitle,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Row(
                                              children: [
                                                SizedBox(width: 6),
                                                Text(
                                                  badges[index].desc,
                                                  style: kLabelText,
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
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
      ],
    );
  }
}

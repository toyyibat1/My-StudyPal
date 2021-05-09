import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/controller/badges_controller.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/core/notifier.dart';
import 'package:my_study_pal/src/views/widgets/badge_tile.dart';

class BadgesScreen extends StatelessWidget {
  // final List<TaskBadges> badges;

  // const BadgesScreen({Key key, this.badges}) : super(key: key);
  // @override

  Widget build(BuildContext context) {
    return GetBuilder<BadgeController>(
        init: BadgeController()..getAuthenticatedUser(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                leading: GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                title: Text(
                  'Badges',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                elevation: 0,
              ),
              body: SafeArea(
                child: Column(
                  children: [
//                    header(context),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kMediumVerticalSpacing,
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Text(
                              'Earn Badges',
                              style: kLabelText,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                              child: controller.state == NotifierState.isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : controller.badges.isEmpty
                                      ? Center(
                                          child: SizedBox(
                                            height: 180,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/no_task.svg',
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
                                          ),
                                        )
                                      : ListView.builder(
                                          itemCount:
                                              BadgeTile().allBadgesList.length,
                                          itemBuilder: (context, index) {
                                            return BadgeTile(
                                              index: index,
                                              badges: BadgeTile().allBadgesList,
                                              controller: controller,
                                            );
                                          },
                                        ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget taskBadges(BadgeController badgeController) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            margin: EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Row(
                  children: [
                    Image.asset(badge),
                    Text(
                      '${badgeController.completedTaskBadges.length}',
                      style: kBodyText2TextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget header(BuildContext context) => Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 16.0,
          right: MediaQuery.of(context).size.width * 0.44,
        ),
        height: 40,
        color: kPrimaryColor2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            Center(
              child: Text(
                'Badges',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
}

List myList = [""];

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';

class BadgesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            header(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kMediumVerticalSpacing,
                    Text(
                      'Earn Badges',
                      style: kLabelText,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 12,
                        itemBuilder: (context, index) => Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 32),
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
                                          'Created an Account',
                                          style: kBodyText2TextStyle,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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

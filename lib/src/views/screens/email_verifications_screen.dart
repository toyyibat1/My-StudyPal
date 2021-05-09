import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/controller/signup_controller.dart';

import '../../core/constants.dart';
import '../../core/images.dart';
import '../widgets/app_button.dart';
import '../widgets/transparent_statusbar.dart';

class EmailVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TransparentStatusbar(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GetBuilder<SignupController>(
            init: SignupController(),
            builder: (controller) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    kExtraLargeVerticalSpacing,
                    header,
                    kLargeVerticalSpacing,
                    Text(
                      "An email has been sent your Email Address. Please check your inbox and follow the instructions to finish setting up your StudyPadi account.",
                      textAlign: TextAlign.center,
                      style: kBodyText2TextStyle,
                    ),
                    kLargeVerticalSpacing,
                    AppButton(
                        label: 'Continue',
                        onPressed: controller.verifyAndContinue),
                    kSmallVerticalSpacing,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get header => Column(
        children: [
          Image.asset(
            logo2,
            width: 65.0,
          ),
          kMediumVerticalSpacing,
          Text(
            "Verify your Email to finish signing up for MyStudyPadi",
            textAlign: TextAlign.center,
            style: kHeadingTextStyle,
          ),
          kSmallVerticalSpacing,
        ],
      );
}

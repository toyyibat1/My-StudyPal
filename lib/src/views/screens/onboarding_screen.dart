import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/onboarding_controller.dart';
import '../../core/constants.dart';
import '../../core/images.dart';
import '../widgets/app_button.dart';
import '../widgets/onboard_column.dart';

class OnboardingScreen extends StatelessWidget {
  List<Widget> _buildPageIndicator(OnboardingController controller) {
    List<Widget> list = [];
    for (int i = 0; i < controller.numPages; i++) {
      list.add(
          i == controller.currentIndex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 12.0,
      width: 12.0,
      decoration: BoxDecoration(
        color: isActive ? kPrimaryColor : Colors.grey[500],
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: Colors.white),
      ),
    );
  }

  final List<OnboardColumn> onboardingPages = <OnboardColumn>[
    OnboardColumn(
        imgPath: onboarding1,
        titletext: Text.rich(
          TextSpan(
            text: 'Welcome to ',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
            children: [
              TextSpan(
                text: 'MyStudy',
                style: GoogleFonts.montserratAlternates(),
              ),
              TextSpan(
                text: 'Padi',
                style: GoogleFonts.montserratAlternates(
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
        subtitleText:
            'Take a step closer to your academic goals with MyStudyPadi'),
    OnboardColumn(
      imgPath: onboarding2,
      titletext: Text(
        'Schedule Study Timetable',
        style: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF333333),
        ),
      ),
      subtitleText:
          'Create a timetable that will help you to study effectively',
    ),
    OnboardColumn(
      imgPath: onboarding3,
      titletext: Text(
        'Create Tasks Seamlessly',
        style: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF333333),
        ),
      ),
      subtitleText: 'Create multiple tasks that can guide your study plans',
    ),
    OnboardColumn(
      imgPath: onboarding4,
      titletext: Text(
        'Invite Friends for Tasks',
        style: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF333333),
        ),
      ),
      subtitleText: 'Help your friends by sharing your study plans with them',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: GetBuilder<OnboardingController>(
          init: OnboardingController(),
          builder: (controller) => Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: controller.pageController,
                    onPageChanged: controller.onChangedFunction,
                    children: onboardingPages,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(controller),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                AppButton(
                  label: "Get Started",
                  color: kPrimaryColor,
                  textColor: Colors.white,
                  onPressed: controller.signUp,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

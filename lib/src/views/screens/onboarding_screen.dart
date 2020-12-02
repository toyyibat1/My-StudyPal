import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_study_pal/src/views/screens/signin_screen.dart';

import '../../core/constants.dart';
import '../../core/images.dart';
import '../widgets/app_button.dart';
import '../widgets/onboard_column.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
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

  List<OnboardColumn> onboardingPages = <OnboardColumn>[
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
        body: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: onboardingPages,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 15),
              AppButton(
                label: "Get Started",
                color: kPrimaryColor,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SigninScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

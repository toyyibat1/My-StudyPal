import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/widgets/app_button.dart';
import '../screens/signin.dart';
import '../../core/constants.dart';

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
      height: 10.0,
      width: isActive ? 10.0 : 10.0,
      decoration: BoxDecoration(
          color: isActive ? kPrimaryColor : Colors.grey[500],
          borderRadius: BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 56),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: <Widget>[
                        OnboardColumn(
                          imgPath: onboarding1,
                          titletext: 'Welcome to MyStudyPadi',
                          subtitleText:'Take a step closer to your academic goals with MyStudyPadi'
                        ),
                        OnboardColumn(
                          imgPath: onboarding2,
                          titletext: 'Schedule Study Timetable',
                          subtitleText:'Create a timetable that will help you to study effectively',
                        ),
                        OnboardColumn(
                          imgPath: onboarding3,
                          titletext: 'Create Tasks Seamlessly',
                          subtitleText:'Create multiple tasks that can guide your study plans',
                        ),
                        OnboardColumn(
                          imgPath: onboarding4,
                          titletext: 'Invite Friends for Tasks',
                          subtitleText:'Help your friends by sharing your study plans with them',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                SizedBox(height: 20),
                _currentPage != _numPages - 1
                    ? AppButton(
                        label: "Get Started",
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                      )
                    : AppButton(
                        label: "Get Started",
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SigninScreen(),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardColumn extends StatelessWidget {
  final String imgPath;
  final String titletext;
  final String subtitleText;

  OnboardColumn({
    this.imgPath,
     this.titletext, this.subtitleText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          imgPath,
          matchTextDirection: false,
          width: MediaQuery.of(context).size.width * 0.9,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              Text(
                titletext,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              Text(
                subtitleText,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}

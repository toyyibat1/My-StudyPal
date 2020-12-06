import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_study_pal/src/core/images.dart';

import 'Onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 5),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => OnboardingScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF225ADC), Color(0xFF102A67)])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  new Image.asset(
                    logo,
                    height: 80.0,
                  ),
                  Text(
                    "MyStudyPadi",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Montserrat Alternates",
                        color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            SpinKitRipple(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

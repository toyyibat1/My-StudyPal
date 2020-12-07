import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/splash_controller.dart';
import '../../core/images.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (controller) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF225ADC), Color(0xFF102A67)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                logo,
                height: 80.0,
              ),
              SizedBox(height: 16.0),
              Text(
                "MyStudyPadi",
                style: GoogleFonts.montserratAlternates(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              SpinKitRipple(color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/controller/signin_with_facebook_controller.dart';
import 'package:my_study_pal/src/controller/signin_with_google_controller.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/core/notifier.dart';
import 'package:my_study_pal/src/views/screens/signin_screen.dart';
import 'package:my_study_pal/src/views/screens/signup_screen.dart';
import 'package:my_study_pal/src/views/widgets/signin_with_tile.dart';

class CreateAccountScreen extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                header,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                GetBuilder<SigninWithFacebookController>(
                    init: SigninWithFacebookController(),
                    builder: (controller) => 
                    SignInWithTile(
                      isLoading: false,
                        ontap:  controller.state == NotifierState.isLoading
                        ? null
                        : controller.signUpUserWithFacebook,   
                          image: facebook,
                          text: 'Continue with Facebook',
                        ),
                      ),
                kLargeVerticalSpacing,
                GetBuilder<SigninWithGoogleController>(
                    init: SigninWithGoogleController(),
                    builder: (controller) => 
                     SignInWithTile(
                      isLoading: false,
                       ontap:  controller.state == NotifierState.isLoading
                        ? null
                        : controller.signUpUserWithGoogle,
                      image: google,
                      text: 'Continue with Google',
                    ),
                  
                ),
                kLargeVerticalSpacing,
                SignInWithTile(
                  isLoading: false,
                  image: email,
                  text: 'Continue with Email',
                  ontap: () => Get.to(SignupScreen()),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                alreadyHaveAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get header => Column(
        children: [
          kExtraLargeVerticalSpacing,
          Image.asset(
            logo2,
            width: 65.0,
          ),
          kMediumVerticalSpacing,
          Text(
            "Create an account",
            textAlign: TextAlign.center,
            style: kHeadingTextStyle,
          ),
          kSmallVerticalSpacing,
        ],
      );

  Widget alreadyHaveAccount() {
    return Text.rich(
      TextSpan(
        text: 'Already have an account?',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        children: <TextSpan>[
          TextSpan(
              text: 'Sign In',
              style: TextStyle(color: kPrimaryColor),
             // recognizer: 
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.off(SigninScreen());
                }
              ),
        ],
      ),
    );
  }
}

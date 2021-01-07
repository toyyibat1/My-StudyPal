import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/controller/create_account_controller.dart';

import '../../controller/social_signin_controller.dart';
import '../../core/constants.dart';
import '../../core/images.dart';
import '../../core/notifier.dart';
import '../widgets/signin_with_tile.dart';
import 'signup_screen.dart';

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                header,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                signupButtons(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                alreadyHaveAccount(),
                SizedBox(height: 24.0),
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

  Widget signupButtons() {
    return GetBuilder<SocialSigininController>(
      init: SocialSigininController(),
      builder: (controller) => controller.state == NotifierState.isLoading
          ? Builder(
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: SizedBox(
                    width: 25.0,
                    height: 25.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  ),
                ),
              ),
            )
          : Column(
              children: [
                SignInWithTile(
                  isLoading: false,
                  ontap: controller.state == NotifierState.isLoading
                      ? null
                      : controller.signUpUserWithFacebook,
                  image: facebook,
                  text: 'Continue with Facebook',
                ),
                kMediumVerticalSpacing,
                SignInWithTile(
                  isLoading: false,
                  ontap: controller.state == NotifierState.isLoading
                      ? null
                      : controller.signUpUserWithGoogle,
                  image: google,
                  text: 'Continue with Google',
                ),
                kMediumVerticalSpacing,
                SignInWithTile(
                  isLoading: false,
                  image: email,
                  text: 'Continue with Email',
                  ontap: () => Get.to(SignupScreen()),
                ),
              ],
            ),
    );
  }

  Widget alreadyHaveAccount() {
    return GetBuilder<CreateAccountController>(
      init: CreateAccountController(),
      builder: (controller) => Center(
        child: Text.rich(
          TextSpan(
            text: 'Already have an account? ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Sign In',
                style: TextStyle(color: kPrimaryColor),
                recognizer: controller.signIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/views/screens/signin_screen.dart';
import 'package:my_study_pal/src/views/screens/signup_screen.dart';
import 'package:my_study_pal/src/views/widgets/signin_with_tile.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
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
                SignInWithTile(
                  image: facebook,
                  text: 'Continue with facebook',
                ),
                kLargeVerticalSpacing,
                SignInWithTile(
                  image: google,
                  text: 'Continue with Google',
                ),
                kLargeVerticalSpacing,
                SignInWithTile(
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
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.to(SigninScreen());
                }),
        ],
      ),
    );
  }
}

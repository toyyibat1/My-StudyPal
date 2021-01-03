import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/create_account_controller.dart';
import '../../core/constants.dart';
import '../../core/images.dart';
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
            child: GetBuilder<CreateAccountController>(
              init: CreateAccountController(),
              builder: (controller) => Column(
                children: [
                  header,
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  SignInWithTile(
                    image: facebook,
                    text: 'Continue with facebook',
                  ),
                  kMediumVerticalSpacing,
                  SignInWithTile(
                    image: google,
                    text: 'Continue with Google',
                  ),
                  kMediumVerticalSpacing,
                  SignInWithTile(
                    image: email,
                    text: 'Continue with Email',
                    ontap: controller.navigateToSignup,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  alreadyHaveAccount(controller),
                  kLargeVerticalSpacing,
                ],
              ),
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

  Widget alreadyHaveAccount(CreateAccountController controller) {
    return Text.rich(
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
    );
  }
}

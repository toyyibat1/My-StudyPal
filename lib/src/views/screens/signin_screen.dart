import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/signin_controller.dart';
import '../../controller/social_signin_controller.dart';
import '../../core/constants.dart';
import '../../core/images.dart';
import '../../core/notifier.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';
import '../widgets/signin_with_tile.dart';
import '../widgets/transparent_statusbar.dart';

class SigninScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TransparentStatusbar(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GetBuilder<SigninController>(
            init: SigninController(),
            builder: (controller) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    kExtraLargeVerticalSpacing,
                    header,
                    kLargeVerticalSpacing,
                    form(controller),
                    kSmallVerticalSpacing,
                    Center(child: Text('or', style: kBodyText1TextStyle)),
                    kSmallVerticalSpacing,
                    socialButtons(),
                    kMediumVerticalSpacing,
                    dontHaveAccount(controller),
                    kMediumVerticalSpacing,
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
            "Sign in to your account",
            textAlign: TextAlign.center,
            style: kHeadingTextStyle,
          ),
          kSmallVerticalSpacing,
        ],
      );

  Widget form(SigninController controller) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            text: 'Email Address',
            controller: controller.emailAddressController,
            validator: controller.validateEmail,
          ),
          kMediumVerticalSpacing,
          AppTextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            text: 'Password',
            obscureText: controller.obscureText,
            controller: controller.passwordController,
            validator: controller.validatePassword,
            suffixIcon: GestureDetector(
              onTap: () => controller.toggle(),
              child: controller.icon,
            ),
          ),
          kSmallVerticalSpacing,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: controller.forgotPasswordScreen,
                child: Text(
                  'Forgot Password?',
                  textAlign: TextAlign.right,
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          kMediumVerticalSpacing,
          AppButton(
            label: 'Sign in',
            color: kPrimaryColor,
            isLoading: controller.state == NotifierState.isLoading,
            textColor: Colors.white,
            onPressed: controller.state == NotifierState.isLoading
                ? null
                : controller.signinUser,
          ),
        ],
      ),
    );
  }

  Widget socialButtons() {
    return GetBuilder<SocialSigininController>(
      init: SocialSigininController(),
      builder: (controller) => controller.state == NotifierState.isLoading
          ? Builder(
              builder: (context) => Center(
                child: SizedBox(
                  width: 25.0,
                  height: 25.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ),
              ),
            )
          : Column(
              children: [
                SignInWithTile(
                  isLoading: controller.state == NotifierState.isLoading,
                  ontap: controller.state == NotifierState.isLoading
                      ? null
                      : controller.signinUserWithFacebook,
                  image: facebook,
                  text: 'Log in with Facebook',
                ),
                kMediumVerticalSpacing,
                SignInWithTile(
                  isLoading: controller.state == NotifierState.isLoading,
                  ontap: controller.state == NotifierState.isLoading
                      ? null
                      : controller.signinUserWithGoogle,
                  image: google,
                  text: 'Log in with Google',
                ),
              ],
            ),
    );
  }

  Widget dontHaveAccount(SigninController controller) {
    return Center(
      child: Text.rich(
        TextSpan(
          text: 'Don\'t have an account yet?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          children: <TextSpan>[
            TextSpan(
              text: ' Sign Up',
              style: TextStyle(color: kPrimaryColor),
              recognizer: controller.createAccount,
            )
          ],
        ),
      ),
    );
  }
}

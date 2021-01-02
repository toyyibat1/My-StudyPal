import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/views/screens/create_account_screen.dart';
import 'package:my_study_pal/src/views/screens/home_screen.dart';
import 'package:my_study_pal/src/views/widgets/signin_with_tile.dart';

import '../../controller/signin_controller.dart';
import '../../controller/signin_with_google_controller.dart';
import '../../controller/signin_with_facebook_controller.dart';
import '../../core/constants.dart';
import '../../core/images.dart';
import '../../core/notifier.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';
import '../widgets/transparent_statusbar.dart';
import '../../services/google_signin.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _obscureText = true;
  Icon icon = Icon(Icons.visibility);
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      if (!_obscureText) {
        icon = Icon(Icons.visibility_off);
      } else {
        icon = Icon(Icons.visibility);
      }
    });
  }

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
                  children: [
                    kExtraLargeVerticalSpacing,
                    header,
                    kLargeVerticalSpacing,
                    form(controller),
                    kSmallVerticalSpacing,
                    Text(
                      'or',
                      style: kBodyText1TextStyle,
                    ),
                    kSmallVerticalSpacing,
                    GetBuilder<SigninWithFacebookController>(
                    init: SigninWithFacebookController(),
                    builder: (controller) => 
                    SignInWithTile(
                        isLoading: controller.state == NotifierState.isLoading,
                        ontap:  controller.state == NotifierState.isLoading
                        ? null
                        :  controller.signinUserWithFacebook,   
                          image: facebook,
                          text: 'Log in with Facebook',
                        ),
                      ),
                    kLargeVerticalSpacing,
                    GetBuilder<SigninWithGoogleController>(
                    init: SigninWithGoogleController(),
                    builder: (controller) => 
                    SignInWithTile(
                      isLoading: controller.state == NotifierState.isLoading,
                        ontap:  controller.state == NotifierState.isLoading
                        ? null
                        : controller.signinUserWithGoogle,   
                          image: google,
                          text: 'Log in with Google',
                        ),
                        ),
                    kSmallVerticalSpacing,
                    dontHaveAccount(controller),
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
            obscureText: _obscureText,
            controller: controller.passwordController,
            validator: controller.validatePassword,
            suffixIcon: GestureDetector(
              onTap: () => _toggle(),
              child: icon,
            ),
          ),
          kSmallVerticalSpacing,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  controller.forgotPassword();
                },
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

  Widget dontHaveAccount(SigninController controller) {
    return Text.rich(
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/core/notifier.dart';

import '../../controller/signup_controller.dart';
import '../../core/constants.dart';
import '../../core/images.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';
import '../widgets/transparent_statusbar.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TransparentStatusbar(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GetBuilder<SignupController>(
            init: SignupController(),
            builder: (controller) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    kExtraLargeVerticalSpacing,
                    header,
                    kLargeVerticalSpacing,
                    form(controller),
                    kMediumVerticalSpacing,
                    haveAnAccount(controller),
                    kLargeVerticalSpacing,
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
            "Create an account",
            textAlign: TextAlign.center,
            style: kHeadingTextStyle,
          ),
          kSmallVerticalSpacing,
          Text(
            'Create a task and plan your study time',
            style: kBodyText1TextStyle,
          ),
        ],
      );

  Widget form(SignupController controller) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            text: 'First Name',
            controller: controller.firstNameController,
            validator: controller.validateNotEmpty,
          ),
          kMediumVerticalSpacing,
          AppTextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            text: 'Last Name',
            controller: controller.lastNameController,
            validator: controller.validateNotEmpty,
          ),
          kMediumVerticalSpacing,
          AppTextField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            text: 'E-mail',
            controller: controller.emailAddressController,
            validator: controller.validateEmail,
          ),
          kMediumVerticalSpacing,
          AppTextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            text: 'Password',
            controller: controller.passwordController,
            obscureText: true,
            validator: controller.validatePassword,
          ),
          kLargeVerticalSpacing,
          AppButton(
            label: 'Sign Up',
            isLoading: controller.state == NotifierState.isLoading,
            color: kPrimaryColor,
            textColor: Colors.white,
            onPressed: controller.state == NotifierState.isLoading
                ? null
                : controller.signupUser,
          ),
        ],
      ),
    );
  }

  Widget haveAnAccount(SignupController controller) {
    return Text.rich(
      TextSpan(
        text: 'Already have an account?',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        children: <TextSpan>[
          TextSpan(
            text: ' Sign In',
            style: TextStyle(color: kPrimaryColor),
            recognizer: controller.signIn,
          )
        ],
      ),
    );
  }
}

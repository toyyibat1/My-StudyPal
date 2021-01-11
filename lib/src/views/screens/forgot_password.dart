import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_study_pal/src/controller/forgot_password_controller.dart';

import '../../core/constants.dart';
import '../../core/images.dart';
import '../../core/notifier.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';
import '../widgets/transparent_statusbar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TransparentStatusbar(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GetBuilder<ForgotPasswordController>(
            init: ForgotPasswordController(),
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
        "Enter your Email to Reset Password",
        textAlign: TextAlign.center,
        style: kHeadingTextStyle,
      ),
      kSmallVerticalSpacing,
    ],
  );

  Widget form(ForgotPasswordController controller) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            keyboardType: TextInputType.emailAddress,
            text: 'Email Address',
            controller: controller.emailAddressController,
            validator: controller.validateEmail,
          ),
          kMediumVerticalSpacing,
          AppButton(
            label: 'Reset Password',
            color: kPrimaryColor,
            isLoading: controller.state == NotifierState.isLoading,
            textColor: Colors.white,
            onPressed: controller.state == NotifierState.isLoading
                ? null
                : controller.forgotPassword,
          ),
          kMediumVerticalSpacing,
          AppButton(
            label: 'Cancel',
            color: Colors.white,
            textColor: kPrimaryColor,
            onPressed: controller.cancelForgotPassword
          ),
        ],
      ),
    );
  }

  // Widget buildPopupDialog(BuildContext context, SigninController controller) {
  //   return new AlertDialog(
  //     title: Text('Enter your Email to Reset Password'),
  //     content: new Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         AppTextField(
  //           keyboardType: TextInputType.emailAddress,
  //           textInputAction: TextInputAction.next,
  //           hintText: "Enter Email Address to reset Password",
  //           text: 'Email Address',
  //           controller: controller.emailAddressController,
  //           validator: controller.validateEmail,
  //         ),
  //         kMediumVerticalSpacing,
  //       ],
  //     ),
  //     actions: <Widget>[
  //       FlatButton(
  //         onPressed: controller.forgotPassword,
  //         textColor: Theme.of(context).primaryColor,
  //         child: Text('Reset Password'),
  //       ),
  //       FlatButton(
  //         onPressed: () {
  //           Get.back();
  //         },
  //         textColor: Theme.of(context).primaryColor,
  //         child: Text('Close'),
  //       ),
  //     ],
  //   );
  // }

}

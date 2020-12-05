import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_study_pal/src/controller/auth_controller.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/core/validation_mixin.dart';
import 'package:my_study_pal/src/views/widgets/app_button.dart';
import 'package:my_study_pal/src/views/widgets/app_textfield.dart';

class SignupScreen extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 80),
                  child: Center(
                      child: Image.asset(
                    logo2,
                    width: 65.0,
                  )),
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
                kLargeVerticalSpacing,
                AppTextField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  text: 'First Name',
                  controller: authController.firstNameController,
                  validator: ValidatorMixin().validateNotEmpty,
                  onSaved: (value) =>
                        authController.firstNameController.text = value,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  text: 'Last Name',
                  controller: authController.lastNameController,
                  validator: ValidatorMixin().validateNotEmpty,
                  onSaved: (value) =>
                        authController.lastNameController.text = value,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  text: 'E-mail',
                  controller: authController.emailController,
                  validator: ValidatorMixin().validateEmail,
                  onSaved: (value) =>
                        authController.emailController.text = value,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  text: 'Password',
                  controller: authController.passwordController,
                  obscureText: true,
                  validator: ValidatorMixin().validatePassword,
                  onSaved: (value) =>
                        authController.passwordController.text = value,
                  onFieldSubmitted: (value){
                   // authController.signupUser();
                  },
                ),
                kLargeVerticalSpacing,
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Sign Up',
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          SystemChannels.textInput.invokeMethod(
                              'TextInput.hide'); //to hide the keyboard - if any
                          authController.registerWithEmailAndPassword(context);
                        }
                      }
                      ),
                    )],
                  ),
                  kLargeVerticalSpacing,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/views/screens/signup_screen.dart';
import 'package:my_study_pal/src/views/widgets/app_button.dart';
import 'package:my_study_pal/src/views/widgets/app_textfield.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16.0),
        child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 80),
              child: Center(child: Image.asset(logo2,
              width: 65.0,)),
            ),
            kMediumVerticalSpacing,
            Text("Sign in to your account",
                textAlign: TextAlign.center, style: kHeadingTextStyle),
            kMediumVerticalSpacing,
            AppTextField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              text: 'Email Address',
              validator: validateEmail,
            ),
            kMediumVerticalSpacing,
            AppTextField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              text: 'Password',
              obscureText: true,
              validator: validatePassword,
            ),
            kMediumVerticalSpacing,
            Row(
              children: [
                Expanded(
                                  child: Text('Forgot Password?',
                    textAlign: TextAlign.right,
                   style: TextStyle(
                    decoration: TextDecoration.underline
                  ),),
                ),
              ],
            ),
            kMediumVerticalSpacing,
             Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Sign in',
                      color: kPrimaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        
                      },
                    ),
                  ),
                ],
              ),
              kSmallVerticalSpacing,
              Text('or'),
              kSmallVerticalSpacing,
            AppFlatButton(
              image: facebook,
              text: 'Login with facebook',
            ),
            kMediumVerticalSpacing,
            AppFlatButton(
              image: google,
              text: 'Login with Google',
              onPressed: () {},
            ),
            kSmallVerticalSpacing,
            Text.rich(
              TextSpan(
                text: 'Don\'t have an account yet?',
                children: <TextSpan>[
                  TextSpan(
                      text: ' Sign Up',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: kPrimaryColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()));
                        })
                ],
              ),
            ),
            kMediumVerticalSpacing
          ],
        ),
    ),
      ));
  }
}

class AppFlatButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final String image;

  const AppFlatButton({
    Key key,
    this.onPressed,
    this.text,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: FlatButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.blue)),
        child: Row(
          children: [
            Image.asset(image),
            SizedBox(
              width: 30,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}

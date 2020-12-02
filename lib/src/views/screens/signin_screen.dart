import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/views/screens/signup_screen.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Center(child: Image.asset(logo2)),
          ),
          SizedBox(height: 60),
          Text("Create an account\n to continue",
              textAlign: TextAlign.center, style: kHeadingTextStyle),
          SizedBox(height: 100),
          AppFlatButton(
            image: facebook,
            text: 'Continue with facebook',
          ),
          AppFlatButton(
            image: google,
            text: 'Continue with google',
            onPressed: () {},
          ),
          AppFlatButton(
            image: email,
            text: 'Continue with email',
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
        ],
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
      margin: EdgeInsets.all(10),
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

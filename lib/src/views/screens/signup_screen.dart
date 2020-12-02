import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/views/screens/home_screen.dart';
import 'package:my_study_pal/src/views/widgets/app_button.dart';
import 'package:my_study_pal/src/views/widgets/app_textfield.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
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
                    validator: validateNotEmpty,
                  ),
                  kMediumVerticalSpacing,
                  AppTextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    text: 'Last Name',
                    validator: validateNotEmpty,
                  ),
                  kMediumVerticalSpacing,
                  AppTextField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    text: 'E-mail',
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
                  kLargeVerticalSpacing,
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          label: 'Sign Up',
                          color: kPrimaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            _signup();
                          },
                        ),
                      ),
                    ],
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

  void _signup() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState.validate()) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
    }
  }
}

String validateNotEmpty(String value) =>
    value.isEmpty ? 'Field cannot be empty' : null;

String validateEmail(String value) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);
  return !emailValid ? 'Enter a Valid Email Address' : null;
}

String validatePassword(String value) =>
    value.length < 6 ? 'Password should be more than 6Characters' : null;

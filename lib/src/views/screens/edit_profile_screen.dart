

import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/views/widgets/app_button.dart';
import 'package:my_study_pal/src/views/widgets/app_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        title: Text('Edit Your Profile'),
        leading: GestureDetector(
          onTap: ()=> Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top:20),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:AssetImage(welcome),
                        backgroundColor: kTextFieldFillColor,
                      ),
                      padding: EdgeInsets.all(2.0),
                      decoration: new BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle
                      ),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: kTextFieldFillColor,
                      child: Icon(Icons.camera_alt_rounded)
                    )
                  ],
                ),
                kSmallVerticalSpacing,
                AppTextField(
                  text: 'First Name',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                 // validator: validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'Last Name',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'Email Address',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'Insitution',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'Course',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                kMediumVerticalSpacing,
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Save',
                        textColor: Colors.white,
                        color: kPrimaryColor,
                        onPressed: (){},
                      ),
                    )
                  ],
                ),
                kLargeVerticalSpacing,
              ],
            )
          ),
        ),
      ),
    );
  }
}
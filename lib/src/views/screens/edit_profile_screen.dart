import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_study_pal/src/core/constants.dart';
import 'package:my_study_pal/src/core/images.dart';
import 'package:my_study_pal/src/views/widgets/app_button.dart';
import 'package:my_study_pal/src/views/widgets/app_textfield.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File _image;
  final ImagePicker picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
        _image = File(pickedFile.path);
    });
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        title: Text('Edit Your Profile'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: (_image != null) ? FileImage(_image) : AssetImage(welcome),
                         // backgroundImage: ,
                          backgroundColor: Colors.grey[50],
                        ),
                        padding: EdgeInsets.all(2.0),
                        decoration: new BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: kTextFieldFillColor,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt_rounded),
                          onPressed: getImage,
                        )
                      )
                    ],
                  ),
                  kSmallVerticalSpacing,
                  AppTextField(
                    text: 'First Name',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    
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
                          onPressed: () {
                            _edit();
                          },
                        ),
                      )
                    ],
                  ),
                  kLargeVerticalSpacing,
                ],
              )),
        ),
      ),
    );
  }

  void _edit() {
    FocusScope.of(context).unfocus();
    if(_formKey.currentState.validate()){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> null));
    }
  }
}

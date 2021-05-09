import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/edit_profile_controller.dart';
import '../../core/constants.dart';
import '../../core/notifier.dart';
import '../../models/app_user.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textfield.dart';
import '../widgets/transparent_statusbar.dart';

class EditProfileScreen extends StatelessWidget {
  final AppUser user;
  EditProfileScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransparentStatusbar(
      child: GetBuilder<EditProfileController>(
        init: EditProfileController(user),
        builder: (controller) => Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            leading: GestureDetector(
              onTap: controller.goBack,
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            title: Text(
              'Edit Your Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            elevation: 0,
          ),
          body: SafeArea(
            child: Column(
              children: [
//                header(context, controller),
                form(context, controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context, EditProfileController controller) =>
      Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 16.0,
          right: MediaQuery.of(context).size.width * 0.33,
        ),
        height: 40,
        color: kPrimaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: controller.goBack,
              child: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            Center(
              child: Text(
                'Edit Your Profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );

  Widget form(BuildContext context, EditProfileController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                kMediumVerticalSpacing,
                // CircleAvatar(
                //   radius: 50,
                //   child: Text(
                //     controller.user.firstName[0]
                //     ?? controller.imageController,
                //     style: kHeadingTextStyle,
                //   ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Color(0xff102A67),
                        child: ClipOval(
                          child: new SizedBox(
                              width: 150.0,
                              height: 150.0,
                              child: Image.file((controller.image),
                                      fit: BoxFit.cover) ??
                                  Text(
                                    controller.user.firstName[0],
                                    style: kHeadingTextStyle,
                                  )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60.0),
                      child: IconButton(
                          icon: Icon(
                            Icons.camera_alt_rounded,
                            size: 30.0,
                          ),
                          onPressed: controller.getImage),
                    ),
                  ],
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'First Name',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.firstNameController,
                  validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'Last Name',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.lastNameController,
                  validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'Email Address',
                  enabled: false,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.emailAddressController,
                  validator: controller.validateNotEmpty,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'Institution',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.institutionController,
                ),
                kMediumVerticalSpacing,
                AppTextField(
                  text: 'Course',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: controller.courseController,
                ),
                kLargeVerticalSpacing,
                AppButton(
                  label: 'Save',
                  color: kPrimaryColor,
                  isLoading: controller.state == NotifierState.isLoading,
                  textColor: Colors.white,
                  onPressed: () => controller.state == NotifierState.isLoading
                      ? null
                      : controller.updateUser(),
                ),
                kMediumVerticalSpacing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_study_pal/src/services/auth_service/auth_service.dart';

import '../core/failure.dart';
import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/app_user.dart';
import '../models/update_user_params.dart';
import '../services/data_connection_service/data_connection_service.dart';

class EditProfileController extends Notifier with ValidationMixin {
  EditProfileController(this.user);
  final AppUser user;
  File _image;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _institutionController = TextEditingController();
  final _courseController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get emailAddressController => _emailAddressController;
  TextEditingController get institutionController => _institutionController;
  TextEditingController get courseController => _courseController;
  File get image => _image;
  GlobalKey<FormState> get formKey => _formKey;

  String imagePath;  

  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      //File imagePath = File(pickedFile.path);
      print(_image);
      update();
    } else {
      print('No image selected.');
    }
  }

  @override
  void onInit() {
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _emailAddressController.text = user.emailAddress;
    _institutionController.text = user.institution;
    _courseController.text = user.course;
    _image = File(_image.path);
    super.onInit();
  }

  Future <void> uploadPic() async {
    if(_image !=null){
      FirebaseStorage storage = FirebaseStorage.instance;
      final String picture1 = "1${DateTime.now().microsecondsSinceEpoch.toString()}.jpg";
      Reference ref = storage.ref().child(picture1);
      UploadTask uploadTask = ref.putFile(_image);
      uploadTask.then((res) async {
        await res.ref.getDownloadURL();
        //String photoUrl = imageUrl;
  });
  }
  }


  void goBack() => Get.back();

  void updateUser() async {
    Get.focusScope.unfocus();

    if (_formKey.currentState.validate()) {
      setState(NotifierState.isLoading);      
      
      try {
        await Get.find<DataConnectionService>().checkConnection();
        uploadPic();
        UpdateUserParams params = UpdateUserParams(
          course: _courseController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          institution: _institutionController.text,
          photoUrl: _image.path
        );

        await Get.find<AuthService>().updateUser(params);
            
        setState(NotifierState.isIdle);

        Get.back();
      } on Failure catch (f) {
        setState(NotifierState.isIdle);
        Get.snackbar(
          'Error',
          f.message,
          colorText: Get.theme.colorScheme.onError,
          backgroundColor: Get.theme.errorColor,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      setState(NotifierState.isIdle);    
  }
  }
}
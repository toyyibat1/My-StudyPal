

import 'dart:io';

import 'package:image_picker/image_picker.dart';

  File image;
  Future <void> selectImage() async {  
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      File imagePath = File(pickedFile.path);
      print(imagePath);
    } else {
      print('No image selected.');
    }
    
  }
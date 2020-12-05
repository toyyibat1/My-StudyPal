import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_study_pal/src/core/validation_mixin.dart';
import 'package:my_study_pal/src/models/user.dart';
import 'package:my_study_pal/src/views/screens/home_screen.dart';
import 'package:my_study_pal/src/views/screens/signin_screen.dart';
import 'package:simple_gravatar/simple_gravatar.dart';
import 'package:get/get.dart';
import '../core/error.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Rx<User> firebaseUser = Rx<User>();
  Rx<UserModel> firestoreUser = Rx<UserModel>();

  //final RxBool admin = false.obs;

  @override
  void onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.value = await getUser;
    firebaseUser.bindStream(user);
    super.onReady();
  }

  @override
  void onClose() {
    firstNameController?.dispose();
    lastNameController?.dispose();
    emailController?.dispose();
    passwordController?.dispose();
    super.onClose();
  }

  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    if (_firebaseUser?.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser());
     // await isAdmin();
     return _firebaseUser;
    }
    if (_firebaseUser == null) {
      Get.offAll(SigninScreen());
    } else {
      Get.offAll(HomeScreen());
    }
  }

  // Firebase user one-time fetch
  Future<User> get getUser async => _auth.currentUser;
  // Firebase user a realtime stream
  Stream<User> get user => _auth.authStateChanges();

  //Streams the firestore user from the firestore collection
  Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');
    if (firebaseUser?.value?.uid != null) {
      return _db
          .doc('/users/${firebaseUser.value.uid}')
          .snapshots()
          .map((snapshot) => UserModel.fromMap(snapshot.data()));
    }
    return null;
  }

  //get the firestore user from the firestore collection
  Future<UserModel> getFirestoreUser() {
    if (firebaseUser?.value?.uid != null) {
      return _db.doc('/users/${firebaseUser.value.uid}').get().then(
          (documentSnapshot) => UserModel.fromMap(documentSnapshot.data()));
    }
    return null;
  }

  //Method to handle user sign in using email and password
  signInWithEmailAndPassword(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim())
          .then((result){
            print('uID: ' + result.user.uid);
            print('email: ' + result.user.email);
          });
      emailController.clear();
      passwordController.clear();
      Get.snackbar("Success", "Login succesfully",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
     Get.to(HomeScreen());
    } catch (error) {
      Get.snackbar(Error().signInErrorTitle, Error().signInError,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
    
  }

  // User registration using email and password
  registerWithEmailAndPassword(BuildContext context) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) async {
        print('uID: ' + result.user.uid);
        print('email: ' + result.user.email);
        //get photo url from gravatar if user has one
        Gravatar gravatar = Gravatar(emailController.text);
        String gravatarUrl = gravatar.imageUrl(
          size: 200,
          defaultImage: GravatarImage.retro,
          rating: GravatarRating.pg,
          fileExtension: true,
        );
        //create the new user object
        UserModel _newUser = UserModel(
            uid: result.user.uid,
            email: result.user.email,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            photoUrl: gravatarUrl);
        //create the user in firestore
        _createUserFirestore(_newUser, result.user);
        firstNameController.clear();
        lastNameController.clear();
        emailController.clear();
        passwordController.clear();
      });
      //Get.off(HomeScreen());
    } catch (error) {  
      Get.snackbar(Error().signUpErrorTitle, error.message,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  
}

  //create the firestore user in users collection
  void _createUserFirestore(UserModel user, User _firebaseUser) {
    _db.doc('/users/${_firebaseUser.uid}').set(user.toJson());
    update();
  }

 
  // Sign out
  Future<void> signOut() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    return _auth.signOut();
    
  }
  
}

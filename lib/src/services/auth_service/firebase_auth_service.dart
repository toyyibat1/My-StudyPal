import 'package:firebase_auth/firebase_auth.dart';

import '../../core/failure.dart';
import '../../models/app_user.dart';
import '../../models/signin_params.dart';
import '../../models/signup_params.dart';
import '../../models/update_email_params.dart';
import '../../models/update_password_params.dart';
import '../../models/update_user_params.dart';
import '../database/firebase_firestore_service.dart';
import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final _auth = FirebaseAuth.instance;

  @override
  Future<AppUser> getAuthenticatedUser() async {
    User user = _auth.currentUser;

    return user != null
        ? await FirebaseFirestoreService().getUserWithId(user.uid)
        : null;
  }

  // This method is for signing up user
  @override
  Future<AppUser> signUp(SignupParams params) async {
    try {
      // Create user in firebase auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: params.emailAddress,
        password: params.password,
      );

      // Get user id to create a custom user object in firestore
      String userId = userCredential.user.uid;

      await FirebaseFirestoreService().createUserWithId(
        userId,
        firstName: params.firstName,
        lastName: params.lastName,
        emailAddress: params.emailAddress,
      );

      return await FirebaseFirestoreService().getUserWithId(userId);
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'email-already-in-use') {
        throw Failure('Email Address is Already Registered');
      } else if (ex.code == 'operation-not-allowed') {
        throw Failure('Something went wrong');
      } else if (ex.code == 'weak-password') {
        throw Failure('Password is not strong enough');
      }
      return null;
    }
  }

  @override
  Future<AppUser> signIn(SignInParams params) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: params.emailAddress,
        password: params.password,
      );

      String userId = userCredential.user.uid;

      return await FirebaseFirestoreService().getUserWithId(userId);
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-disabled') {
        throw Failure('User has been disabled');
      } else if (ex.code == 'operation-not-allowed') {
        throw Failure('Something went wrong');
      } else if (ex.code == 'user-not-found' || ex.code == 'wrong-password') {
        throw Failure('Incorrect Email or Password');
      }
      return null;
    }
  }

  @override
  Future<AppUser> updateUser(UpdateUserParams params) async {
    try {
      User user = _auth.currentUser;

      await FirebaseFirestoreService().updateUserWithId(
        user.uid,
        firstName: params.fullName,
        phoneNumber: params.phoneNumber,
        emailAddress: params.emailAddress,
      );
      return await FirebaseFirestoreService().getUserWithId(user.uid);
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message);
    }
  }

  @override
  Future<void> updateEmail(UpdateEmailParams params) async {
    try {
      User user = _auth.currentUser;

      AuthCredential authCredential = EmailAuthProvider.credential(
        email: user.email,
        password: params.oldPassword,
      );

      await user.reauthenticateWithCredential(authCredential);

      await user.updateEmail(params.emailAddress);

      await user.sendEmailVerification();
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'wrong-password' ||
          ex.code == 'user-mismatch' ||
          ex.code == 'user-not-found') {
        throw Failure('The password entered is not correct');
      }
    }
  }

  @override
  Future<void> updatePassword(UpdatePasswordParams params) async {
    try {
      User user = _auth.currentUser;

      AuthCredential authCredential = EmailAuthProvider.credential(
        email: user.email,
        password: params.oldPassword,
      );

      await user.reauthenticateWithCredential(authCredential);

      await user.updatePassword(params.newPassword);
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'wrong-password' ||
          ex.code == 'user-mismatch' ||
          ex.code == 'user-not-found') {
        throw Failure('The password entered is not correct');
      }
    }
  }

  @override
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } on FirebaseAuthException {
      throw Failure('Something went wrong');
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/failure.dart';
import '../../models/app_user.dart';
import '../../models/forgot_password_params.dart';
import '../../models/signin_params.dart';
import '../../models/signup_params.dart';
import '../../models/update_user_params.dart';
import '../database_service/firebase_firestore_service.dart';
import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final _auth = FirebaseAuth.instance;
  final _facebookAuth = FacebookAuth.instance;
  final _googleAuth = GoogleSignIn();

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
     
     try {
        await userCredential.user.sendEmailVerification();
        // Get user id to create a custom user object in firestore
        print("Email Sent");
       String userId = userCredential.user.uid;

      await FirebaseFirestoreService().createUserWithId(
        userId,
        firstName: params.firstName,
        lastName: params.lastName,
        emailAddress: params.emailAddress,
      );

      return await FirebaseFirestoreService().getUserWithId(userId);
        
     } catch (e) {
        print("An error occured while trying to send email verification");
        print(e.message);
     }  
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
    return null;
  }

  @override
  Future<AppUser> signIn(SignInParams params) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: params.emailAddress,
        password: params.password,
      );
     if (userCredential.user.emailVerified) {
      //return await userCredential.uid;
      //return null;
     
      String userId = userCredential.user.uid;
      return await FirebaseFirestoreService().getUserWithId(userId);
     }else {
       await userCredential.user.sendEmailVerification();
       throw Failure('User email not verified');    
     }
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
  Future<void> updateUser(UpdateUserParams params) async {
    try {
      User user = _auth.currentUser;

      await FirebaseFirestoreService().updateUserWithId(user.uid,
          firstName: params.firstName,
          lastName: params.lastName,
          course: params.course,
          institution: params.institution,
          photoUrl: params.photoUrl);
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message);
    }
  }

  @override
  Future<void> forgotPassword(ForgotPasswordParams params) async {
    try {
      await _auth.sendPasswordResetEmail(email: params.emailAddress);
    } catch (ex) {
      throw Failure(ex.message);
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

  @override
  Future<void> signOutWithFacebook() async {
    try {
      return await FacebookAuth.instance.logOut();
    } on Exception {
      throw Failure('Something went wrong');
    }
  }

  @override
  Future<void> signOutWithGoogle() async {
    try {
      return await _googleAuth.signOut();
    } on Exception {
      throw Failure('Something went wrong');
    }
  }

  @override
  Future<AppUser> signUpWithGoogle() async {
    await Firebase.initializeApp();

    try {
      GoogleSignInAccount googleSignInAccount = await _googleAuth.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User user = (await _auth.signInWithCredential(credential)).user;

      String userId = user.uid;
      String name = user.displayName;
      String emailAddress = user.email;

      int firstSpace = name.indexOf(" ");
      String firstName = name.substring(0, firstSpace);
      String lastName = name.substring(firstSpace).trim();

      await FirebaseFirestoreService().createUserWithId(
        user.uid,
        firstName: firstName,
        lastName: lastName,
        emailAddress: emailAddress,
      );

      return await FirebaseFirestoreService().getUserWithId(userId);
    } catch (ex) {
      throw Failure(ex.message);
    }
  }

  @override
  Future<AppUser> signUpWithFacebook() async {
    try {
      AccessToken accessToken = await _facebookAuth.login();
      OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);
      User user = (await _auth.signInWithCredential(credential)).user;

      String userId = user.uid;
      String name = user.displayName;
      String emailAddress = user.email;

      int firstSpace = name.indexOf(" ");
      String firstName = name.substring(0, firstSpace);
      String lastName = name.substring(firstSpace).trim();

      await FirebaseFirestoreService().createUserWithId(
        userId,
        firstName: firstName,
        lastName: lastName,
        emailAddress: emailAddress,
      );

      return await FirebaseFirestoreService().getUserWithId(userId);
    } on FacebookAuthException catch (e) {
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("login failed");
          break;
      }
    }
    return null;
  }

  @override
  Future<AppUser> signInWithFacebook() async {
    try {
      AccessToken accessToken = await _facebookAuth.login();

      OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);

      User user = (await _auth.signInWithCredential(credential)).user;

      AppUser appUser =
          await FirebaseFirestoreService().getUserWithId(user.uid);

      if (appUser != null) {
        return appUser;
      } else {
        await _auth.signOut();
        throw Failure(
            'You don\'t have an account with us. Please signup to continue');
      }
    } on FacebookAuthException catch (e) {
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          throw Failure("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          throw Failure("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          throw Failure("login failed");
          break;
      }
    } on Exception catch (e) {
      throw Failure(e.toString());
    }
    return null;
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleAuth.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User user = (await _auth.signInWithCredential(credential)).user;

      AppUser appUser =
          await FirebaseFirestoreService().getUserWithId(user.uid);

      if (appUser != null) {
        return appUser;
      } else {
        await _auth.signOut();
        throw Failure(
            'You don\'t have an account with us. Please signup to continue');
      }
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-disabled') {
        throw Failure('User has been disabled');
      } else if (ex.code == 'not signup') {
        throw Failure('Please signup to continue');
      } else if (ex.code == 'user-not-found') {
        throw Failure('User not found');
      }
      return null;
    }
  }
}

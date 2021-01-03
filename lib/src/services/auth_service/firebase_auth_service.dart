import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

  String firstName1;
  String lastName1;
  String email;
  String photoUrl;

  @override
  Future<AppUser> signInWithGoogle() async {
    await Firebase.initializeApp();
    //try {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    User user = authResult.user;

    String userId = authResult.user.uid;

    String name = user.displayName;

    int firstSpace = name.indexOf(" "); // detect the first space character
    firstName1 = name.substring(
        0, firstSpace); // get everything upto the first space character
    lastName1 = name.substring(firstSpace).trim();

    email = user.email;
    photoUrl = user.photoURL;

    await FirebaseFirestoreService().createUserWithGoogle(user.uid,
        firstName: firstName1,
        lastName: lastName1,
        emailAddress: user.email,
        photoUrl: user.photoURL);
    return await FirebaseFirestoreService().getUserWithId(userId);
  }

  @override
  Future<void> signOutWithGoogle() async {
    try {
      return await _googleSignIn.signOut();
    } on FirebaseAuthException {
      throw Failure('Something went wrong');
    }
  }
}

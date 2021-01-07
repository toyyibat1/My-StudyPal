import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../core/notifier.dart';
import '../core/validation_mixin.dart';
import '../models/update_user_params.dart';
import '../views/screens/signin_screen.dart';
import 'database_service/firebase_firestore_service.dart';

class AuthService extends Notifier with ValidationMixin {
  // Dependencies
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  //AppUser user;

  Future<User> googleSignIn() async {
    // Start
    setState(NotifierState.isLoading);
    // Step 1
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    // Step 2
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    User user = authResult.user;
    // Step 3
    void updateUserData(UpdateUserParams params) async {
      await FirebaseFirestoreService().createUserWithId(user.uid,
          firstName: params.firstName,
          lastName: params.lastName,
          course: params.course,
          institution: params.institution,
          photoUrl: params.photoUrl);
    }
    // Done

    setState(NotifierState.isIdle);
    //  Get.off(HomeScreen(user2: user));
    print("signed in " + user.displayName);
    return user;
  }

  void signOut() {
    _auth.signOut();
    Get.off(SigninScreen());
  }
}

final AuthService authService = AuthService();
// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn _googleSignIn = GoogleSignIn();

// Future<User> signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//     // Create a new credential
//     final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     // Once signed in, return the UserCredential
//     final UserCredential authResult = await _auth.signInWithCredential(credential);
//     final User user = authResult.user;

//     print('authResult');
//     print(authResult);

//     return user;
//   }

/// Sign in with Google
Future<User> googleSignIn() async {
  try {
    // GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    // GoogleSignInAuthentication googleAuth =
    //     await googleSignInAccount.authentication;
    // final AuthCredential credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );
    // AuthResult result = await _auth.signInWithCredential(credential);
    // User user = result.user;
    // Gravatar gravatar = Gravatar(user.email);
    // String gravatarUrl = gravatar.imageUrl(
    //   size: 200,
    //   defaultImage: GravatarImage.retro,
    //   rating: GravatarRating.pg,
    //   fileExtension: true,
    // );
    // UserModel _newUser = UserModel(
    //     uid: user.uid,
    //     email: user.email,
    //     name: user.displayName,
    //     photoUrl: photoUrl);
    // _auth.signInWithEmailAndPassword(email: email, password: password);
    // UserData(collection: 'users').upsert(_newUser.toJson());
    // Update user data
    // updateUserData(user);
    //return user;
  } catch (error) {
    print(error);
    return null;
  }
}

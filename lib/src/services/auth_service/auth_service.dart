import '../../models/app_user.dart';
import '../../models/forgot_password_params.dart';
import '../../models/signin_params.dart';
import '../../models/signup_params.dart';
import '../../models/update_user_params.dart';

abstract class AuthService {
  Future<AppUser> getAuthenticatedUser();

  Future<AppUser> signUp(SignupParams params);

  Future<AppUser> signIn(SignInParams params);

  Future<AppUser> signUpWithGoogle();

  Future<AppUser> signUpWithFacebook();

  Future<AppUser> signInWithGoogle();

  Future<AppUser> signInWithFacebook();

  Future<void> updateUser(UpdateUserParams params);

  Future<void> forgotPassword(ForgotPasswordParams params);

  Future<void> signOut();

  Future<void> signOutWithFacebook();

  Future<void> signOutWithGoogle();
}

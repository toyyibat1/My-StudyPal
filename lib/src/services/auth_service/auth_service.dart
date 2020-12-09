import '../../models/app_user.dart';
import '../../models/signin_params.dart';
import '../../models/signup_params.dart';
import '../../models/update_email_params.dart';
import '../../models/update_password_params.dart';
import '../../models/update_user_params.dart';

abstract class AuthService {
  Future<AppUser> getAuthenticatedUser();

  Future<AppUser> signUp(SignupParams params);

  Future<AppUser> signIn(SignInParams params);

  Future<AppUser> updateUser(UpdateUserParams params);

  Future<void> updateEmail(UpdateEmailParams params);

  Future<void> updatePassword(UpdatePasswordParams params);

  Future<void> signOut();
}

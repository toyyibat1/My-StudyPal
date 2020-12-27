import '../../models/app_user.dart';
import '../../models/signin_params.dart';
import '../../models/signup_params.dart';
import '../../models/update_user_params.dart';

abstract class AuthService {
  Future<AppUser> getAuthenticatedUser();

  Future<AppUser> signUp(SignupParams params);

  Future<AppUser> signIn(SignInParams params);

  Future<void> updateUser(UpdateUserParams params);

  Future<void> signOut();
}

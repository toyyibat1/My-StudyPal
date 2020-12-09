import 'package:flutter/foundation.dart';

class SignInParams {
  final String emailAddress;
  final String password;

  SignInParams({
    @required this.emailAddress,
    @required this.password,
  });
}

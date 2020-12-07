import 'package:flutter/foundation.dart';

class SignupParams {
  final String emailAddress;
  final String password;
  final String firstName;
  final String lastName;

  SignupParams({
    @required this.emailAddress,
    @required this.password,
    @required this.firstName,
    @required this.lastName,
  });
}

import 'package:flutter/foundation.dart';

class UpdateUserParams {
  final String fullName;
  final String phoneNumber;
  final String emailAddress;

  UpdateUserParams({
    @required this.fullName,
    @required this.phoneNumber,
    @required this.emailAddress,
  });
}

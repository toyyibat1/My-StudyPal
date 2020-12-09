import 'package:flutter/foundation.dart';

class UpdateEmailParams {
  final String oldPassword;
  final String emailAddress;

  UpdateEmailParams({
    @required this.oldPassword,
    @required this.emailAddress,
  });
}

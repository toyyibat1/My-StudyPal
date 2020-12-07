import 'package:flutter/foundation.dart';

class UpdatePasswordParams {
  final String oldPassword;
  final String newPassword;

  UpdatePasswordParams({
    @required this.oldPassword,
    @required this.newPassword,
  });
}

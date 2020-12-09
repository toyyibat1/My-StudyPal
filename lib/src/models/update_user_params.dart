import 'package:flutter/foundation.dart';

class UpdateUserParams {
  final String firstName;
  final String lastName;
  final String institution;
  final String course;

  UpdateUserParams({
    @required this.firstName,
    @required this.lastName,
    @required this.institution,
    @required this.course,
  });
}

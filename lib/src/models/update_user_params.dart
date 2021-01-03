import 'package:flutter/foundation.dart';

class UpdateUserParams {
  final String firstName;
  final String lastName;
  final String institution;
  final String course;
  final String photoUrl;

  UpdateUserParams({
    @required this.firstName,
    @required this.lastName,
    @required this.institution,
    @required this.course,
    @required this.photoUrl
  });
}

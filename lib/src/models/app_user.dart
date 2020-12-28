import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String firstName;
  final String emailAddress;
  final String lastName;
  final String institution;
  final String course;
  final String photoUrl;

  AppUser({
    this.id,
    this.firstName,
    this.emailAddress,
    this.lastName,
    this.institution,
    this.course,
    this.photoUrl
  });

  factory AppUser.fromDocumentSnapshot(DocumentSnapshot snapshot) => AppUser(
        id: snapshot.id,
        firstName: snapshot.data()['firstName'] ?? '',
        emailAddress: snapshot.data()['emailAddress'] ?? '',
        lastName: snapshot.data()['lastName'] ?? '',
        institution: snapshot.data()['institution'] ?? '',
        course: snapshot.data()['course'] ?? '',
        photoUrl: snapshot.data()['photoUrl'] ?? ''
      );
}

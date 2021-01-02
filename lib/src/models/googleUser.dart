import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleUser {
  final String id;
  final String emailAddress;
  final String institution;
  final String course;
  final String photoUrl;
  final String firstName;
  final String lastName;

  GoogleUser({
    this.id,
    this.emailAddress,
    this.institution,
    this.course,
    this.photoUrl,
    this.firstName,
    this.lastName
  });

  factory GoogleUser.fromDocumentSnapshot(DocumentSnapshot snapshot) => GoogleUser(
        id: snapshot.id,
        emailAddress: snapshot.data()['emailAddress'] ?? '',
        institution: snapshot.data()['institution'] ?? '',
        course: snapshot.data()['course'] ?? '',
        photoUrl: snapshot.data()['photoUrl'] ?? '',
        firstName: snapshot.data()['firstName'] ?? '',
        lastName: snapshot.data()['lastName'] ?? '',
      );
}

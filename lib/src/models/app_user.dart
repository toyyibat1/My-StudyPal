import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String firstName;
  final String emailAddress;
  final String lastName;

  AppUser({
    this.id,
    this.firstName,
    this.emailAddress,
    this.lastName,
  });

  factory AppUser.fromDocumentSnapshot(DocumentSnapshot snapshot) => AppUser(
        id: snapshot.id,
        firstName: snapshot.data()['firstName'] ?? '',
        emailAddress: snapshot.data()['emailAddress'] ?? '',
        lastName: snapshot.data()['lastName'] ?? '',
      );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/app_user.dart';
import '../../models/task.dart';
import '../../models/task_params.dart';
import 'database_service.dart';

class FirebaseFirestoreService implements DatabaseService {
  final userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<AppUser> getUserWithId(String userId) async {
    final snapshot = await userCollection.doc(userId).get();
    return AppUser.fromDocumentSnapshot(snapshot);
  }

  @override
  Future<void> createUserWithId(String userId,
      {String emailAddress, String firstName, String lastName}) async {
    return await userCollection.doc(userId).set({
      'emailAddress': emailAddress,
      'firstName': firstName,
      'lastName': lastName,
    });
  }

  @override
  Future<void> updateUserWithId(String userId,
      {String emailAddress, String fullName, String phoneNumber}) async {
    return await userCollection.doc(userId).update({
      'emailAddress': emailAddress,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
    });
  }

  @override
  Future<Task> createTask(TaskParams params) async {
    User user = FirebaseAuth.instance.currentUser;

    DateTime startTime = DateTime(params.date.year, params.date.month,
        params.date.day, params.startTime.hour, params.startTime.minute);
    DateTime endTime = DateTime(params.date.year, params.date.month,
        params.date.day, params.endTime.hour, params.endTime.minute);

    DocumentReference reference =
        await userCollection.doc(user.uid).collection('tasks').add({
      'name': params.name,
      'description': params.description,
      'date': params.date.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'completed': false,
      'timestamp': Timestamp.now(),
    });

    DocumentSnapshot snapshot = await reference.get();

    return Task.fromDocumentSnapshot(snapshot);
  }

  @override
  Future<void> changeTaskStatus(String taskId, bool status) async {
    User user = FirebaseAuth.instance.currentUser;

    return await userCollection
        .doc(user.uid)
        .collection('tasks')
        .doc(taskId)
        .update(
      {
        'completed': status,
      },
    );
  }

  @override
  Future<List<Task>> getAllTasks() async {
    User user = FirebaseAuth.instance.currentUser;

    List<Task> cards = [];

    List<QueryDocumentSnapshot> snapshot =
        (await userCollection.doc(user.uid).collection("tasks").get()).docs;

    snapshot.forEach(
      (card) => cards.add(Task.fromDocumentSnapshot(card)),
    );

    return cards;
  }
}

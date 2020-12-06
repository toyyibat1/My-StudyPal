import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference studyPadiCollection =
      FirebaseFirestore.instance.collection('studyPlan');

  Future updateData(
    String email,
    String firstName,
    String lastName,
    String photoUrl,
    String institution,
    String course,
    String studyGoals,
    String periodToBeAchieved,
    String endOfSemester,
    String startOfSemester,
    String startOfExam,
    String endOfExam,
    String taskName,
    String taskDescription,
    String taskDate,
    String taskStart,
    String taskEnd,
  ) async {
    return await studyPadiCollection.doc(uid).set({
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'photoUrl': photoUrl,
      'institution': institution,
      'course': course,
      'studyGoals': studyGoals,
      'periodToBeAchieved': periodToBeAchieved,
      'endOfSemester': endOfSemester,
      'startOfSemester': startOfSemester,
      'startOfExam': startOfExam,
      'endOfExam': endOfExam,
      'taskDescription': taskDescription,
      'taskEnd': taskEnd,
      'taskDate': taskDate,
      ' taskStart': taskStart,
      'taskName': taskName,
    });
  }

//  //task list from snapshot
//  List<TaskData> _taskListFromSnapshot(QuerySnapshot snapshot) {
//    return snapshot.docs.map((doc) {
//      return TaskData(
//        taskName: doc.data()['taskName'] ?? '',
//        taskDate: doc.data()['taskDate'] ?? '',
//        taskStart: doc.data()['taskStart'] ?? '',
//        taskEnd: doc.data()['taskEnd'] ?? '',
//        taskDescription: doc.data()['taskDescription'] ?? '',
//      );
//    }).toList();
//  }
//
//  //3user data fom snapshot
//  TaskData _userTaskFromSnapshot(DocumentSnapshot snapshot) {
//    return TaskData(
//      uid: uid,
//      taskName: snapshot.data()['taskName'],
//      taskDescription: snapshot.data()['taskDescription'],
//      taskDate: snapshot.data()['taskDate'],
//      taskStart: snapshot.data()['taskStart'],
//      taskEnd: snapshot.data()['taskEnd'],
//    );
//  }
//
//  //1 get user doc string
//  Stream<TaskData> get taskData {
//    return studyPadiCollection.doc(uid).snapshots().map(_userTaskFromSnapshot);
//  }
}
